//
//  viewControllerExtension.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/30/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    /// muestra el CustomIndicator sobre la vista
    func showIndicator(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let indicator = CustomIndicator(frame: CGRect(x: window.frame.midX - 15, y: window.frame.midY - 15, width: 30, height: 30))
        window.addSubview(indicator)
        window.bringSubview(toFront: indicator)
    }
    
    /// borra el CustomIndicator del uiview del appDelegate
    func hideIndicator(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        for item in window.subviews {
            if item is CustomIndicator{
                item.removeFromSuperview()
            }
        }
    }
    
    
    /// realiza la navegacion hacia la interfaz de detalle de pelicula
    ///
    /// - Parameter movie: data de la pelicula
    func goToMovieDetail(movie : Movie){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movie-detail-controller") as! MovieDetailViewController
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// para sobreescribir donde se agregan los delegados de la interfaz
    @objc func setupDelegates(){
    }
}

extension UISearchBar {
    
    /// cambia de color el uitextfield del searchbar
    ///
    /// - Parameter color: color por el que se cambiara
    func changeSearchBarColor(color : UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                if subSubView is UITextField {
                    let textField = subSubView as! UITextField
                    textField.backgroundColor = color
                    break
                }
            }
        }
    }
}
