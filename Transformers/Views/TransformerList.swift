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
    
    var robotList: [Transformer] = [] {
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransformerListCell.self, forCellReuseIdentifier: "TransformerListCell")
        
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
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func onAddTapped(_ sender: UIButton) {
        coordinator?.createNewRobot()
    }
    
    @objc private func addTapped(_ sender: Any) {
        coordinator?.createNewRobot()
    }
    
}

extension TransformerList: UITableViewDelegate {
    
}

extension TransformerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return robotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerListCell") as! TransformerListCell
        cell.name = robotList[indexPath.row].name
        return cell
    }
    
}

fileprivate class TransformerListCell: UITableViewCell {
    
    var name: String = "TransformerName" {
        didSet {
            labelName.text = name
        }
    }
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textBlack
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        self.addSubview(labelName)
        labelName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14).isActive = true
    }
    
}
