//
//  BattleListCell.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/27/21.
//

import UIKit

enum WinnerData: String {
    case autobot
    case deception
    case initial = ":"
    case equal = "="
    case none = "none"
    case missing = "no game"
}

class BattleListCell: UITableViewCell {

    let redColor = UIColor(red: 0.97, green: 0.0, blue: 0.3, alpha: 1.0)
    let purpleColor = UIColor(red: 0.2, green: 0.14, blue: 0.38, alpha: 0.8)
    
    private var winnerConstraint: NSLayoutConstraint!
    
    public var autobotData: Transformer? = nil {
        didSet {
            icon1.isHidden = autobotData == nil ? true : false
            labelName1.text = autobotData?.name ?? ""
        }
    }
    
    public var decepticonData: Transformer? = nil {
        didSet {
            icon2.isHidden = decepticonData == nil ? true : false
            labelName2.text = decepticonData?.name ?? ""
        }
    }
    
    private var estXPos: CGFloat = 0.0
    
    public func showWinner() {
        if autobotData != nil && decepticonData == nil { winner(wd: .missing) }
        
        if let autobotData = autobotData, let decepticonData = decepticonData {
            
            if autobotData.name == "Optimus Prime" && decepticonData.name == "Predaking" { winner(wd: .equal); return }
            if autobotData.name == "Optimus Prime" && decepticonData.name != "Predaking" { winner(wd: .autobot); return }
            if autobotData.name != "Optimus Prime" && decepticonData.name == "Predaking" { winner(wd: .deception); return }
            
            if autobotData.totalRank == decepticonData.totalRank { winner(wd: .equal); return }
            if autobotData.totalRank > decepticonData.totalRank { winner(wd: .autobot); return }
            if autobotData.totalRank < decepticonData.totalRank { winner(wd: .deception); return }
        }
        
    }
    
    private let icon1: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon_autobot")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let labelName1: UILabel = {
        let label = UILabel()
        label.text = "Autobot"
        label.textColor = Colors.textBlack
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let icon2: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon_decept")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let labelName2: UILabel = {
        let label = UILabel()
        label.text = "Decepticon"
        label.textAlignment = .right
        label.textColor = Colors.textBlack
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelVS: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textColor = Colors.textBlack
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let winner: UIImageView = {
        let imgView = UIImageView()
        imgView.isHidden = true
        imgView.image = UIImage(named: "winner")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
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
        
        self.contentView.addSubview(icon1)
        icon1.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        icon1.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        
        self.contentView.addSubview(icon2)
        icon2.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        icon2.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        
        self.contentView.addSubview(labelName1)
        labelName1.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelName1.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 45).isActive = true
        
        self.contentView.addSubview(labelName2)
        labelName2.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelName2.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -45).isActive = true
        
        self.contentView.addSubview(labelVS)
        labelVS.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelVS.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        
        self.contentView.addSubview(winner)
        winner.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        //winner.leftAnchor.constraint(equalTo: self.labelVS.leftAnchor, constant: 10).isActive = true
        //winner.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        //NSLayoutConstraint(item: winner, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    }
    
    private func winner(wd: WinnerData) {
        switch wd {
        case .autobot:
            estXPos = -20
            winner.isHidden = false
        case .deception:
            estXPos = 20
            winner.isHidden = false
        case .initial:
            estXPos = 0
            winner.isHidden = true
        case .equal:
            estXPos = 0
            labelVS.text = "="
            winner.isHidden = true
        case .none:
            estXPos = 0
            labelVS.text = "none"
            winner.isHidden = true
        case .missing:
            estXPos = 0
            labelVS.text = "no game"
            winner.isHidden = true
        }
        
        if winnerConstraint == nil {
            winnerConstraint = winner.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: estXPos)
            winnerConstraint.isActive = true
        }
    }

}
