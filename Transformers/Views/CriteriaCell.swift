//
//  CriteriaCell.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/22/21.
//

import UIKit

protocol CriteriaCellDelegate: class {
    func criteriaValueChanged(criteria: RobotCriteria, id: Int)
}

class CriteriaCell: UITableViewCell {
    
    @IBOutlet weak var labelCriteria: UILabel!
    @IBOutlet weak var criteriaLevel: UISegmentedControl!

    weak var delegate: CriteriaCellDelegate?
    var criteriaId: Int?
    var criteria: RobotCriteria? = nil {
        didSet {
            labelCriteria.text = criteria?.criteria.rawValue
            if let level = criteria?.level, level > 0 {
                criteriaLevel.selectedSegmentIndex = level - 1
            } else {
                criteriaLevel.selectedSegmentIndex = 0
            }
        }
    }
    
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
        guard let criteriaType = criteria?.criteria, let criteriaId = criteriaId else {
            return
        }
        let level = criteriaLevel.selectedSegmentIndex + 1
        delegate?.criteriaValueChanged(criteria: RobotCriteria(criteria: criteriaType, level: level), id: criteriaId)
    }

}
