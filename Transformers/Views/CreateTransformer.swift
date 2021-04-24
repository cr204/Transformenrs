//
//  CreateTransformer.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

enum Team: String {
    case autobots = "A"
    case decepticons = "D"
}

class CreateTransformer: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    var criteriaTypes:[RobotCriteria] = [RobotCriteria(criteria: .strength, level: 1),
                                          RobotCriteria(criteria: .interlligence, level: 1),
                                          RobotCriteria(criteria: .speed, level: 1),
                                          RobotCriteria(criteria: .endurance, level: 1),
                                          RobotCriteria(criteria: .rank, level: 1),
                                          RobotCriteria(criteria: .courage, level: 1),
                                          RobotCriteria(criteria: .firepower, level: 1),
                                          RobotCriteria(criteria: .skill, level: 1)
                                            ]
    var team: Team = .autobots
    
    @IBOutlet weak var imgRobot: UIImageView!
    @IBOutlet weak var btnAuto: UIButton!
    @IBOutlet weak var btnDesp: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Transformer"
        tableView.dataSource = self
        tableView.delegate = self
       
        self.setupViews()
    }
 
    
    private func setupViews() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        activityIndicator.hidesWhenStopped = true

        tableView.separatorStyle = .none
        btnAuto.addTarget(self, action: #selector(selectGroup), for: .touchUpInside)
        btnDesp.addTarget(self, action: #selector(selectGroup), for: .touchUpInside)
        
    }
    
    
    @objc private func selectGroup(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            imgRobot.image = UIImage(named: "Optimus_Prime")
            labelTitle.text = "Autobots"
            team = .autobots
        case 1:
            imgRobot.image = UIImage(named: "Predaking")
            labelTitle.text = "Decepticons"
            team = .decepticons
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
                print("New Robot: \(text)")
                self.saveNewRobot(name: text)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveNewRobot(name: String) {
        self.activityIndicator.startAnimating()
        
        let newRobot = Transformer(courage: criteriaTypes[5].level,
                                   endurance: criteriaTypes[3].level,
                                   firepower: criteriaTypes[6].level,
                                   id: "",
                                   intelligence: criteriaTypes[1].level,
                                   name: name,
                                   rank: criteriaTypes[4].level,
                                   skill: criteriaTypes[7].level,
                                   speed: criteriaTypes[2].level,
                                   strength: criteriaTypes[0].level,
                                   team: team.rawValue,
                                   team_icon: "")
        
        APIManager.shared.addNew(transformer: newRobot, completion: { result in
            
            //print(result)
            switch result {
            case .success(_):
                self.returnBack()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    
    private func returnBack() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            //self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
}


extension CreateTransformer: CriteriaCellDelegate {
    func criteriaValueChanged(criteria: RobotCriteria, id: Int) {
        print("Set: \(criteria.criteria.rawValue), level: \(criteria.level)")
        criteriaTypes[id] = criteria
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
        cell.delegate = self
        cell.criteriaId = indexPath.row
        cell.criteria = criteriaTypes[indexPath.row]
        cell.criteriaLevel.selectedSegmentIndex = criteriaTypes[indexPath.row].level
        return cell
    }
    
    
}
