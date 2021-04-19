//
//  Coordinator.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
