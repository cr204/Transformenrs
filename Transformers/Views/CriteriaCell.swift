//
//  CriteriaCell.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/22/21.
//

import UIKit

protocol CriteriaCellDelegate: class {
    func onSelected(level: Int)
}

class CriteriaCell: UITableViewCell {
    
    @IBOutlet weak var labelCriteria: UILabel!
    @IBOutlet weak var criteriaLevel: UISegmentedControl!

    weak var delegate: CriteriaCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        self.criteriaLevel.addTarget(self, action: #selector(onLevelChanged), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onLevelChanged(_ sender: Any) {
        delegate?.onSelected(level: criteriaLevel.selectedSegmentIndex)
    }

}
