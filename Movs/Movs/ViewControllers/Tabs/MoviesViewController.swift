//
//  MoviesViewController.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var collectionview: UICollectionView!
    var cellId = "MovieCollectionViewCell"
    var peliculas: Array<Pelicula> = Array()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p2 = Pelicula()
        let p3 = Pelicula()
        let p1 = Pelicula()
        p1.titulo = "hola1"
        p1.favorito=true
        peliculas = [p1,p2,p3]
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        let nib = UINib.init(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionview.register(nib, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        
        let defaults = UserDefaults.standard
        
        
        
        
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: peliculas, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "pelis")
            defaults.synchronize()
            
            
            let decoded = defaults.data(forKey: "pelis")
            print("result")
            let savedArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! [Pelicula]
            let _ = savedArray.map({print($0.titulo)})
            
        } catch {
            print("error")
        }

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCollectionViewCell
        cell.inicializarCelda(pelicula: peliculas[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = MovieViewController()
        viewController.view.backgroundColor = .white
        viewController.imageView.backgroundColor = .negro
        
        let backItem = UIBarButtonItem()
        backItem.title = "Movies"
        backItem.tintColor = .negro
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        self.navigationController?.pushViewController(viewController, animated: true)
     
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio = 1.3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + flowLayout.minimumInteritemSpacing
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(2))
        return CGSize(width: size, height: Int(Double(size) * ratio))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
