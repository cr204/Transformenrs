//
//  CriteriaListCell.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/26/21.
//

import UIKit

class CriteriaListCell: UITableViewCell {

    let redColor = UIColor(red: 0.97, green: 0.0, blue: 0.3, alpha: 1.0)
    let purpleColor = UIColor(red: 0.2, green: 0.14, blue: 0.38, alpha: 0.8)
    
    public var data: Transformer? = nil {
        didSet {
            labelName.text = data?.name
            status.setColor(color: data?.team == "A" ? redColor : purpleColor)
            if let data = data {
                let totalRank = (data.strength + data.intelligence + data.speed + data.endurance + data.rank + data.courage + data.firepower + data.skill) / 8
                status.setStatus(CGFloat(totalRank))
            }
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
        
        self.contentView.addSubview(labelName)
        labelName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 45).isActive = true
        
        self.contentView.addSubview(status)
        status.widthAnchor.constraint(equalToConstant: 70).isActive = true
        status.heightAnchor.constraint(equalToConstant: 12).isActive = true
        status.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        status.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }

}
