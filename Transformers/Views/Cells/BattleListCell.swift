//
//  BattleListCell.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/27/21.
//

import UIKit

class BattleListCell: UITableViewCell {

    let redColor = UIColor(red: 0.97, green: 0.0, blue: 0.3, alpha: 1.0)
    let purpleColor = UIColor(red: 0.2, green: 0.14, blue: 0.38, alpha: 0.8)
    
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
        
    }

}
