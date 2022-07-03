//
//  BaseViewController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

extension UIImageView {

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class BaseViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width-40)/2, y: (UIScreen.main.bounds.height-40)/2, width: 40, height: 40))
        
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.color = .darkGray
        view.addSubview(activityIndicator)

        // Do any additional setup after loading the view.
    }

    func successfulAlertMessage(_ mensaje: String, complete : @escaping () -> () ) {
        // create the alert
        let alert = UIAlertController(title: "Éxito", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: {
            (_: UIAlertAction!) in
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

    func getUIColor(hex: String, alpha: Double = 1.0) -> UIColor? {
        var cleanString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cleanString.hasPrefix("#")) {
            cleanString.remove(at: cleanString.startIndex)
        }
        if ((cleanString.count) != 6) {
            return nil
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cleanString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
