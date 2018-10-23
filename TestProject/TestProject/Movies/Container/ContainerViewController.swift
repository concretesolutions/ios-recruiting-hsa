//
//  ContainerViewController.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    var delegate: MovieViewController?
    var presenter: ContainerPresenter?
    //Selected movie to get details
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        //Init presenter
        self.presenter = ContainerPresenter(delegate: self)
        //Rounded corners
        containerView.roundedCorners(cRadius: 10)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //This is to fix a bug when Details is open but the user change tabs
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let containerView = segue.destination as? DetailMovieTableViewController{
            containerView.movie = self.movie
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //Load favorites from above view
        self.delegate?.presenter?.loadFavorites()
        self.delegate?.collectionView.reloadData()
    }
    
    
}

extension ContainerViewController: ContainerEventResponse{
    //declare events in future....
}
