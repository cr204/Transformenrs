//
//  TransformerInfo.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/25/21.
//

import UIKit

class TransformerInfo: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var robotImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var criterias: [RobotCriteria] = []
    var transformer: Transformer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let addButton   = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransformerInfoListCell.self, forCellReuseIdentifier: "TransformerInfoCell")
        
        self.setupViews()
        self.updateViews()
    }
    
    private func setupViews() {
        
    }
    
    private func updateViews() {
        guard let transformer = transformer else { return }
        
        self.title = transformer.name
        teamIcon.image = UIImage(named: transformer.team == "A" ? "autobot" : "decept")
        teamName.text = transformer.team == "A" ? "Autobots" : "Decepticons"
        teamName.textColor = transformer.team == "A" ? Colors.autobotColor : Colors.decepticoColor
        robotImage.image = UIImage(named: transformer.team == "A" ? "Optimus_Prime" : "Predaking")
        
        criterias = []
        criterias.append(RobotCriteria(criteria: .strength, level: transformer.strength))
        criterias.append(RobotCriteria(criteria: .interlligence, level: transformer.intelligence))
        criterias.append(RobotCriteria(criteria: .speed, level: transformer.speed))
        criterias.append(RobotCriteria(criteria: .endurance, level: transformer.endurance))
        criterias.append(RobotCriteria(criteria: .rank, level: transformer.rank))
        criterias.append(RobotCriteria(criteria: .courage, level: transformer.courage))
        criterias.append(RobotCriteria(criteria: .firepower, level: transformer.firepower))
        criterias.append(RobotCriteria(criteria: .skill, level: transformer.skill))
        
        tableView.reloadData()
    }
    
    @objc private func editTapped(_ sender: Any) {
        
    }

}

extension TransformerInfo: UITableViewDelegate {
    
}

extension TransformerInfo: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerInfoCell") as! TransformerInfoListCell
        cell.data = criterias[indexPath.row]
        cell.team = transformer?.team ?? "A"
        return cell
    }
}

fileprivate class TransformerInfoListCell: UITableViewCell {
    
    public var data: RobotCriteria? = nil {
        didSet {
            if let data = data {
            labelName.text = data.criteria.rawValue
                let level = data.level
                status.setStatus(CGFloat(level))
            }
        }
    }
    
    public var team: String = "A" {
        didSet {
            status.setColor(color: team == "A" ? Colors.autobotColor : Colors.decepticoColor)
        }
    }
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textBlack
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let status: StatusView = {
        let view = StatusView()
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        self.contentView.addSubview(labelName)
        labelName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0).isActive = true
        
        self.contentView.addSubview(status)
        status.widthAnchor.constraint(equalToConstant: 150).isActive = true
        status.heightAnchor.constraint(equalToConstant: 12).isActive = true
        status.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        status.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
    }
    
    
}
