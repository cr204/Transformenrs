//
//  CriteriaModel.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/24/21.
//

import Foundation

enum CriteriaType: String {
    case strength = "Strength"
    case interlligence = "Intelligence"
    case speed = "Speed"
    case endurance = "Endurance"
    case rank = "Rank"
    case courage = "Courage"
    case firepower = "Firepower"
    case skill = "Skill"
}

struct RobotCriteria {
    let criteria: CriteriaType
    let level: Int
}
