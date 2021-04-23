//
//  MainCoordinator.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
//        self.singOut()
//        self.injectToken()
        
//        if AuthManager.shared.isSignedIn {
//            self.transformerList()
//        } else {
//            start()
//        }
        
        createNewRobot()
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func transformerList() {
        let vc = TransformerList.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createNewRobot() {
        let vc = CreateTransformer.instantiate()
        vc.coordinator = self
       navigationController.pushViewController(vc, animated: true)
    }
    
    
    func singOut() {
        AuthManager.shared.signOut { bool in
            print("Signed Out: \(bool)")
        }
    }
    
    func injectToken() {
        AuthManager.shared.signOut { bool in
            if bool {
                AuthManager.shared.cacheToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1NWVNZUUdEQWxyZEw0dEpzdDIzIiwiaWF0IjoxNjE4NjI0NzU1fQ.JPYljmaQv1ztlXzW-poUEvWtjyQ6qi_cWEppoD7q_5I")
                print("Test token injected!")
            }
        }
    }
    
}

