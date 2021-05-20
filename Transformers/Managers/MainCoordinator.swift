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
        
        if AuthManager.shared.isSignedIn {
            self.transformerList()
        } else {
            start()
        }
        
//        let tempList: [Transformer] = [
//            Transformer(courage: 8, endurance: 9, firepower: 6, id: "12345", intelligence: 7, name: "Optimus Prime", rank: 7, skill: 8, speed: 8, strength: 10, team: "A", team_icon: "img"),
//            Transformer(courage: 5, endurance: 6, firepower: 6, id: "12345", intelligence: 9, name: "Autobot 2", rank: 7, skill: 3, speed: 8, strength: 7, team: "A", team_icon: "img"),
//            Transformer(courage: 8, endurance: 8, firepower: 9, id: "12345", intelligence: 8, name: "Autobot 3", rank: 6, skill: 2, speed: 8, strength: 9, team: "A", team_icon: "img"),
//            Transformer(courage: 7, endurance: 6, firepower: 3, id: "12345", intelligence: 7, name: "Autobot 4", rank: 8, skill: 4, speed: 8, strength: 10, team: "A", team_icon: "img"),
//            Transformer(courage: 9, endurance: 6, firepower: 6, id: "12345", intelligence: 4, name: "Autobot 5", rank: 9, skill: 9, speed: 8, strength: 10, team: "A", team_icon: "img"),
//            Transformer(courage: 5, endurance: 5, firepower: 3, id: "67890", intelligence: 8, name: "Decepticon 1", rank: 5, skill: 8, speed: 8, strength: 4, team: "D", team_icon: "img"),
//            Transformer(courage: 6, endurance: 6, firepower: 7, id: "67890", intelligence: 6, name: "Decepticon 2", rank: 8, skill: 6, speed: 8, strength: 5, team: "D", team_icon: "img"),
//            Transformer(courage: 8, endurance: 7, firepower: 6, id: "67890", intelligence: 2, name: "Decepticon 3", rank: 4, skill: 9, speed: 8, strength: 6, team: "D", team_icon: "img"),
//            Transformer(courage: 3, endurance: 8, firepower: 7, id: "67890", intelligence: 9, name: "Decepticon 4", rank: 8, skill: 5, speed: 8, strength: 7, team: "D", team_icon: "img"),
//            Transformer(courage: 8, endurance: 9, firepower: 8, id: "67890", intelligence: 7, name: "Decepticon 5", rank: 9, skill: 6, speed: 8, strength: 3, team: "D", team_icon: "img"),
//            Transformer(courage: 6, endurance: 6, firepower: 9, id: "67890", intelligence: 5, name: "Predaking", rank: 7, skill: 8, speed: 8, strength: 6, team: "D", team_icon: "img")
//        ]
//
//        battleList(tempList)
        
//        let robot = Transformer(courage: 6, endurance: 6, firepower: 9, id: "67890", intelligence: 5, name: "Predaking", rank: 7, skill: 8, speed: 8, strength: 6, team: "D", team_icon: "img")
//        editRobot(robot)
        
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
    
    func editRobot(_ robot: Transformer) {
        let vc = EditTransformer.instantiate()
        vc.coordinator = self
        vc.transformer = robot
       navigationController.pushViewController(vc, animated: true)
    }
    
    func robotDetails(robot: Transformer) {
        let vc = TransformerInfo.instantiate()
        vc.coordinator = self
        vc.transformer = robot
        navigationController.pushViewController(vc, animated: true)
    }
    
    func battleList(_ list: [Transformer]) {
        let vc = BattleViewController.instantiate()
        vc.coordinator = self
        vc.transformers = list
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

