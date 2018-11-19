//
//  ErrorView.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit
import Lottie

struct MessageData{
    let message: String
    let animationName: String
}

enum MessageType{
    case noConnection
    case genericError
    case emptyFavorites
    case noSearchResults
    
    func getData() -> MessageData{
        switch self{
        case .noConnection:
            return MessageData(message: "Sin conexión a internet", animationName: "no-connection")
        case .genericError:
            return MessageData(message: "Ups.. Ocurrió un error inesperado", animationName: "broken_stick_error")
        case .emptyFavorites:
            return MessageData(message: "Aquí encontrarás tus favoritos una vez que los agregues.", animationName: "no-connection")
        case .noSearchResults:
            return MessageData(message: "No se encontraron resultados", animationName: "no-connection")
        }
    }
}

class MessageView: UIView {
    
    @IBOutlet weak var animationCanvas: LOTAnimationView!
    @IBOutlet weak var errorMessageLbl: UILabel!
    var messageType: MessageType = .genericError {
        didSet{
            self.errorMessageLbl.text = messageType.getData().message
            self.addAnimation(named: messageType.getData().animationName)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        fromNib()
    }
    
    func addAnimation(named: String){
        let animationView = LOTAnimationView(name: named)
        animationView.frame = animationCanvas.frame
        animationView.frame.origin = CGPoint.zero
        animationCanvas.addSubview(animationView)
        animationView.layoutAttachAll(to: animationCanvas)
        animationView.loopAnimation = true
        animationView.play()
    }
}
