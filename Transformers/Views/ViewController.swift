//
//  ViewController.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }

    @IBAction func loginTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        AuthManager.shared.getToken(urlLink: Links.getToken) { res in
            print("RESULT: \(res)")
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if res {
                    self.coordinator?.transformerList()
                }
            }
            
        }
    }
}

