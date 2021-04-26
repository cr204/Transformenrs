//
//  BattleViewController.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/26/21.
//

import UIKit

class BattleViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnResult: UIButton!
    
    weak var coordinator: MainCoordinator?
    var transformers: [Transformer]? = nil {
        didSet {
            self.updateViews()
        }
    }
    
    private var autobots:[Transformer] = []
    private var decepticons:[Transformer] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transformers Battle"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(BattleListCell.self, forCellReuseIdentifier: "BattleListCell")
        
    }
    
    private func updateViews() {
        guard let transformers = transformers else {
            return
        }
        
        // Filtering
        autobots = transformers.filter { $0.team == "A" }
        decepticons = transformers.filter { $0.team == "D" }
        
        // Sorting
        autobots.sort { $0.totalRank > $1.totalRank }
        decepticons.sort { $0.totalRank > $1.totalRank }
        
        print("T: \(transformers.count)   A: \(autobots.count)  D: \(decepticons.count)")
        
    }
    
}


extension BattleViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        coordinator?.robotDetails(robot: robotList[indexPath.row])
    }
    
}

typealias Battle = (autobot: Transformer?, decepticon: Transformer?)

extension BattleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autobots.count >= decepticons.count ? autobots.count : decepticons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BattleListCell") as! BattleListCell
        let autobot: Transformer? = autobots.count > indexPath.row ? autobots[indexPath.row] : nil
        let desepticon: Transformer? = decepticons.count > indexPath.row ? decepticons[indexPath.row] : nil
        cell.autobotData = autobot
        cell.decepticonData = desepticon
        cell.showWinner()
        return cell
    }
    
}
