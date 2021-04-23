//
//  CreateTransformer.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class CreateTransformer: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    let criteriaNames = ["Strength", "Intelligence", "Speed", "Endurance", "Rank", "Courage", "Firepower", "Skill"]
    var criteriaValues = [0, 0, 0, 0, 0, 0, 0, 0]
    
    @IBOutlet weak var imgRobot: UIImageView!
    @IBOutlet weak var btnAuto: UIButton!
    @IBOutlet weak var btnDesp: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Transformer"
        tableView.dataSource = self
        tableView.delegate = self
       
        self.setupViews()
    }
 
    
    private func setupViews() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))

        tableView.separatorStyle = .none
        btnAuto.addTarget(self, action: #selector(selectGroup), for: .touchUpInside)
        btnDesp.addTarget(self, action: #selector(selectGroup), for: .touchUpInside)
        
    }
    
    
    @objc private func selectGroup(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            imgRobot.image = UIImage(named: "Optimus_Prime")
            labelTitle.text = "Autobots"
        case 1:
            imgRobot.image = UIImage(named: "Predaking")
            labelTitle.text = "Decepticons"
        default:
            return
        }
    }
    
    
    var textField: UITextField?
    
    func configurationTextField(textField: UITextField!) {
        if (textField) != nil {
            self.textField = textField!
            self.textField?.placeholder = "Robot name";
            self.textField?.autocapitalizationType = .sentences
        }
    }
    
    @objc private func saveTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Save Transformer", message: "Please enter new Transformer name", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
            if let text = self.textField?.text {
                print("User click Ok button")
                print(text)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension CreateTransformer: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
}

extension CreateTransformer: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CriteriaCell") as! CriteriaCell
        cell.labelCriteria.text = criteriaNames[indexPath.row]
        cell.criteriaLevel.selectedSegmentIndex = criteriaValues[indexPath.row]
        return cell
    }
    
    
}
