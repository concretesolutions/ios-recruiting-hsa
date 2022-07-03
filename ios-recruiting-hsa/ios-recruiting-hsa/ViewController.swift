//
//  ViewController.swift
//  ios-recruiting-hsa
//
//  Created by training on 29-06-22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    func successfulAlertMessage(_ mensaje: String, complete : @escaping () -> ()) {
        // create the alert
        let alert = UIAlertController(title: "Éxito", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            complete()
            return
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func successfulAlertMessage(_ mensaje: String) {
        // create the alert
        let alert = UIAlertController(title: "Éxito", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAlertMessage(_ mensaje: String) {
        // create the alert
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}

extension UIImageView{
    func loadFrom(URLAddress: String ){
        guard let url = URL(string: URLAddress)else {
            return
        }
        DispatchQueue.main.async {[weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self?.image = loadedImage
                }
            }
        }
    }
}
