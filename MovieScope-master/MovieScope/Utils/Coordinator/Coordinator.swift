//
//  Coordinator.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

//Protocolo para la implementacion de la clase coordinator
protocol CoordinatorFlowDelegate: class {
    func start()
    func stop()
    func removeCoordinator(coordinator: Coordinator)
    func addChildCoordinator(child: Coordinator)
}

class Coordinator: NSObject, CoordinatorFlowDelegate{
    
    var childCoordinators: [Coordinator] = []
    var interceptor: AppNavigationInterceptor?
    weak var delegate: CoordinatorFlowDelegate?
    var name = ""
    
    unowned let navController: UINavigationController
    
    init(navigationController: UINavigationController, nameid: String, parentdelegate: CoordinatorFlowDelegate?){
        self.name = nameid
        self.navController = navigationController
        self.delegate = parentdelegate
    }
    
    //Todo coordinator debe de iniciar un flujo
    func start(){
        fatalError("Se debe implementar la funcion start")
    }
    
    //Al detenerse un coordinator se detiene el flujo asociado a él
    func stop(){
        delegate?.removeCoordinator(coordinator: self)
    }
    
    //Un coordinator solo puede tener activo un tipo de flujo como hijo, por ejemplo el coordinador que contiene las listas de peliculas no puede iniciar un nuevo flujo de detalle de pelicula si ya contiene un detalle de pelicula activo como hijo.
    func addChildCoordinator(child: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === child }) else {
            print("Coordinator: \(self.name), ya contiene: \(child.name)")
            return
        }
        childCoordinators.append(child)
    }
    
    func removeCoordinator(coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else {
            print("Coordinator: \(self.name),  no contiene: \(coordinator.name)")
            return
        }
        childCoordinators.remove(at: index)
        navController.delegate = self.interceptor
    }
    
}
