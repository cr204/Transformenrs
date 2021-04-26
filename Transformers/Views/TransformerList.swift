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
    
    let btnWar: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setTitle("WAR", for: .normal)
        btn.layer.cornerRadius = 30
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private var robotList: [Transformer] = [] {
        didSet {
            print("List loaded:")
            self.updateData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transformers"
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        let addButton   = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [editButton, addButton]
        
        tableView.isHidden = true
        labelInfo.isHidden = true
        bigAddButton.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransformerListCell.self, forCellReuseIdentifier: "TransformerListCell")
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchListData()
    }
    
    
    private func fetchListData() {
        APIManager.shared.getTransformerList { result in
            switch result {
            case .success(let model):
                self.robotList = model.sorted { $0.team < $1.team }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setupViews() {
        bigAddButton.layer.cornerRadius = 8
        
        activityIndicator.startAnimating()
        
        view.addSubview(btnWar)
        btnWar.widthAnchor.constraint(equalToConstant: 60).isActive = true
        btnWar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        NSLayoutConstraint(item: btnWar, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.7, constant: 0).isActive = true
        NSLayoutConstraint(item: btnWar, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.83, constant: 0).isActive = true
        
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
            print(self.robotList.count)
        }
    }
    
    
    @IBAction func onAddTapped(_ sender: UIButton) {
        coordinator?.createNewRobot()
    }
    
    @objc private func addTapped(_ sender: Any) {
        coordinator?.createNewRobot()
    }
    
    @objc private func editTapped(_ sender: UIBarButtonItem) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    private func removeTransformer(id: String) {
        print("Remove: \(id)")
        
        APIManager.shared.removeTransformer(id: id) { result in
            switch result {
            case .success(let res):
                print("Res: \(res)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}

extension TransformerList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            var itemToDelete:Transformer!
            itemToDelete = robotList[indexPath.row]
            robotList.remove(at: indexPath.row)
            
            self.removeTransformer(id: itemToDelete.id)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        view.setNeedsLayout()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(robotList[indexPath.row].name)
        coordinator?.robotDetails(robot: robotList[indexPath.row])
    }
    
}

extension TransformerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return robotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerListCell") as! TransformerListCell
        cell.data = robotList[indexPath.row]
        return cell
    }
    
}
