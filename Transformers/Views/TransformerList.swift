//
//  TransformerList.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/19/21.
//

import UIKit

class TransformerList: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    fileprivate var presenter: TransformerListPresenter!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var bigAddButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let btnWar: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setTitle("WAR", for: .normal)
        btn.layer.cornerRadius = 30
        btn.isEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TransformerListPresenter()
        
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
        self.presenter.fetchListData { result in
            switch result {
            case .success(_):
                self.updateData()
            case .failure(_):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(title: "Network Error", message: "Problem loading data,\n please try again")
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            (result : UIAlertAction) -> Void in
            self.activityIndicator.startAnimating()
            self.fetchListData()
        }
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    private func setupViews() {
        bigAddButton.layer.cornerRadius = 8
        
        activityIndicator.startAnimating()
        
        view.addSubview(btnWar)
        btnWar.addTarget(self, action: #selector(onWarTapped), for: .touchUpInside)
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
            self.btnWar.isEnabled = true
            print(self.presenter.robotList.count)
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
    
    @objc private func onWarTapped(_ sender: Any) {
        coordinator?.battleList(self.presenter.robotList)
    }
    
}

extension TransformerList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            var itemToDelete:Transformer!
            itemToDelete = presenter.robotList[indexPath.row]
            presenter.robotList.remove(at: indexPath.row)
            
            self.presenter.removeTransformer(id: itemToDelete.id)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        view.setNeedsLayout()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(robotList[indexPath.row].name)
        coordinator?.robotDetails(robot: presenter.robotList[indexPath.row])
    }
    
}

extension TransformerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.robotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerListCell") as! TransformerListCell
        cell.data = presenter.robotList[indexPath.row]
        return cell
    }
    
}
