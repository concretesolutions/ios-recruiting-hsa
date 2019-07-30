//
//  FilterVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/28/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import UIKit

protocol FilterDelegate: class{
    
    func doneFilterButtonTapped(genreId:Int?,year:Int?)
}


class FilterVC: UIViewController {
    
    class func createController(selectedGenreId:Int?, selectedYear:Int?) -> FilterVC{
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let filterVC = storyboard.instantiateInitialViewController()! as! FilterVC
        filterVC.selectedGenreId = selectedGenreId
        filterVC.selectedYear = selectedYear
        return filterVC
    }
    
    //MARK: UIVars
    
    @IBOutlet weak var genresButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    var dummyTextField = UITextField()
    
    lazy var genrePickerView:UIPickerView = {
        let pickerView = UIPickerView.init()
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        return pickerView
    }()
    
    lazy var yearPickerView:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        return pickerView
    }()
    
    
    
    //MARK: Vars
    
    weak var delegate:FilterDelegate?
    
    var genres:[GenreModel] = []
    var years:[Int] = {
        var years = Array(1930...2020)
        years.reverse()
        return years
    }()
    
    var selectedGenreId: Int?
    var selectedYear: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.getGenres()
    }
    
    //MARK: Setups
    
    private func setupView(){
        
        //Confg Navigation
        navigationItem.title = "Filter"
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        let saveFilter = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(filterButtonTapped(_:)))
        saveFilter.tintColor = .black
        
        navigationItem.rightBarButtonItems = [saveFilter]
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        ]
        dummyTextField.inputAccessoryView = toolBar
        view.addSubview(dummyTextField)
        
        // set initial value in yearPickerView //
        
        if let selectedYear = self.selectedYear,
            let selectedIndex = self.years.firstIndex(where: {$0 == selectedYear}){
            
            DispatchQueue.main.async {
                self.pickerView(
                    self.yearPickerView,
                    didSelectRow: selectedIndex,
                    inComponent:0
                )
            }
        }
        
        
    }
    
    //MARK: - Funcs
    
    @IBAction func genresButtonTapped(_ sender: Any) {
        
        if self.genres.isEmpty{return}
        self.dummyTextField.inputView = genrePickerView
        self.dummyTextField.becomeFirstResponder()
    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        self.dummyTextField.inputView = yearPickerView
        self.dummyTextField.becomeFirstResponder()
    }
    
    @objc func doneButtonTapped() {
        
        if dummyTextField.inputView == genrePickerView{
            let selectedRow = genrePickerView.selectedRow(inComponent: 0)
            pickerView(genrePickerView, didSelectRow: selectedRow, inComponent: 0)
        }
        
        if dummyTextField.inputView == yearPickerView{
            let selectedRow = yearPickerView.selectedRow(inComponent: 0)
            pickerView(yearPickerView, didSelectRow: selectedRow, inComponent: 0)
        }
        
        self.dummyTextField.resignFirstResponder()
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.doneFilterButtonTapped(genreId: selectedGenreId, year: selectedYear)
        
    }
    
    @IBAction func cancelFilterbuttonTapped(){
        self.navigationController?.popViewController(animated: true)
        self.delegate?.doneFilterButtonTapped(genreId: nil, year: nil)
    }
    
    private func getGenres(){
        
        GlobalServices.shared.genreServices.getGenre() { (response) in
            
            switch response {
                
            case .success(data: let genre):
                
                self.genres = genre.genres
                
                // set initial value in genrePickerView //
                
                if let selectedGenreId = self.selectedGenreId,
                    let selectedIndex = self.genres.firstIndex(where: {$0.id == selectedGenreId}){
                    
                    DispatchQueue.main.async {
                        self.pickerView(
                            self.genrePickerView,
                            didSelectRow: selectedIndex,
                            inComponent:0
                        )
                    }
                }
                
                DispatchQueue.main.async {
                    self.genrePickerView.reloadAllComponents()
                }
                
            case .error(error: let error):
                
                print(error.localizedDescription)
                
            }
            
        }
        
    }
    
}

//MARK: Implement PickerView

extension FilterVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == genrePickerView{
            return genres.count
        }
        
        if pickerView == yearPickerView{
            return years.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genrePickerView{
            return genres[row].name
        }
        
        if pickerView == yearPickerView{
            return "\(years[row])"
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == genrePickerView{
            genresButton.setTitle(genres[row].name, for: .normal)
            selectedGenreId = genres[row].id
        }
        
        if pickerView == yearPickerView{
            dateButton.setTitle("\(years[row])", for: .normal)
            selectedYear = years[row]
        }
        
    }
    
}
