//
//  TransformerList.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class TransformerList: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var bigAddButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var robotList: [TransformerResponce] = [] {
        didSet {
            print("List loaded:")
            self.updateData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transformers"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableView.isHidden = true
        labelInfo.isHidden = true
        bigAddButton.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        self.fetchListData()
        self.setupViews()
    }
    
    
    private func fetchListData() {
        // New Releases
        APIManager.shared.getTransformerList { result in
            
            switch result {
            case .success(let model):
                self.robotList = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    private func setupViews() {
        bigAddButton.layer.cornerRadius = 8
        
        activityIndicator.startAnimating()
        
    }
    
    private func updateData() {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
            print(self.robotList.count)
        }
    }
    
    
    @IBAction func onAddTapped(_ sender: UIButton) {
        coordinator?.createNewRobot()
    }

    @objc private func addTapped(_ sender: Any) {
        coordinator?.createNewRobot()
    }
    

}
