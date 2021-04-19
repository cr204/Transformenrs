//
//  TransformerList.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class TransformerList: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var bigAddButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transformers"
        tableView.isHidden = true
        
        self.setupViews()
    }
    

    private func setupViews() {
        bigAddButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func onAddTapped(_ sender: UIButton) {
        coordinator?.createNewRobot()
    }

}
