//
//  ViewController.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
        coordinator?.transformerList()
    }
}
