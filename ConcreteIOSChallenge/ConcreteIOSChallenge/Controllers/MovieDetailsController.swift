//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Accenture on 01-07-22.
//

import UIKit
import WebKit

class MovieDetailsController: UIViewController {
    
    //TITULO DE LA PELICULA
    private let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    //SINOPSIS DE LA PELICULA
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    //ANIO DE LA PELICULA
    private let releaseDate: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "2022-03-30"
        return label
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(releaseDate)
        
        configureConstraints()
    }
    
    //SE ESTABLECEN LAS PROPIDEADDES DE LOS LABEL Y SU POSICION EN LA PANTALLA 
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let releaseDateLabelConstraints = [
            releaseDate.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(releaseDateLabelConstraints)
    }
    
    public func configure(with model: MovieViewModel) {
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        releaseDate.text = model.releaseDate
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
//    func didGetUserLogin(_ status : APIStatusType, _ response: LoginResponse?) {
//        print("Callback didGetUserLogin")
//        print("code    : \(status)")
//        if status == .success {
//            activityIndicator.stopAnimating()
//            successfulAlertMessage("Autentificación éxitosa", complete: didGoToBienvenidos)
//        } else {
//            activityIndicator.stopAnimating()
//            self.okLabel.text = response?.error ?? ""
//            errorAlertMessage("Credenciales incorrectas")
//        }
//    }
    
//    func successfulAlertMessage(_ mensaje: String) {
//        // create the alert
//        let alert = UIAlertController(title: "Éxito", message: mensaje, preferredStyle: .alert)
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func errorAlertMessage(_ mensaje: String) {
//        // create the alert
//        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//    }
}
