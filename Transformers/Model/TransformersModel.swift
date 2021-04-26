//
//  TransformersModel.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/21/21.
//

import Foundation

struct ListResponce: Codable {
    let transformers: [Transformer]
}


struct Transformer: Codable {
    let courage: Int
    let endurance: Int
    let firepower: Int
    let id: String
    let intelligence: Int
    let name: String
    let rank: Int
    let skill: Int
    let speed: Int
    let strength: Int
    let team: String
    let team_icon: String
    
    var totalRank: Int {
        return (courage + endurance + firepower + intelligence + rank + skill + speed + strength) / 8
    }
}
