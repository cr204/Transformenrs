//
//  TransformerListCell.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/25/21.
//

import UIKit

class TransformerListCell: UITableViewCell {
    
    let redColor = UIColor(red: 0.97, green: 0.0, blue: 0.3, alpha: 1.0)
    let purpleColor = UIColor(red: 0.2, green: 0.14, blue: 0.38, alpha: 0.8)
    
    public var data: Transformer? = nil {
        didSet {
            icon.image = UIImage(named: data?.team == "A" ? "icon_autobot" : "icon_decept")
            labelName.text = data?.name
            status.setColor(color: data?.team == "A" ? redColor : purpleColor)
            if let data = data {
                let totalRank = (data.strength + data.intelligence + data.speed + data.endurance + data.rank + data.courage + data.firepower + data.skill) / 8
                status.setStatus(CGFloat(totalRank))
            }
        }
    }
    
    private let icon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon_autobot")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
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
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        
        self.contentView.addSubview(icon)
        icon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        
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


fileprivate class StatusView: UIView {
    
    private var filledWidthConstraint: NSLayoutConstraint!
    
    private let filled: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.0, blue: 0.3, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.97, green: 0.0, blue: 0.3, alpha: 1.0).cgColor
        
        self.addSubview(filled)
        filled.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setColor(color: UIColor) {
        filled.backgroundColor = color
        self.layer.borderColor = color.cgColor
    }
    
    public func setStatus(_ value: CGFloat) {
        let estWidth: CGFloat = value / 10
        if filledWidthConstraint == nil {
            filledWidthConstraint = filled.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: estWidth)
            filledWidthConstraint.isActive = true
        }   
    }
    
    
}
