//
//  CreateTransformerPresenter.swift
//  Transformers
//
//  Created by Jasur Rajabov on 5/20/21.
//

import Foundation

enum Team: String {
    case autobots = "A"
    case decepticons = "D"
}

class CreateTransformerPresenter {
    
    func addNew(transformerName: String, team: Team, criteriaTypes: [RobotCriteria], completion: @escaping ((Result<Transformer, Error>)) -> Void) {
        
        let newRobot = Transformer(courage: criteriaTypes[5].level,
                                   endurance: criteriaTypes[3].level,
                                   firepower: criteriaTypes[6].level,
                                   id: "",
                                   intelligence: criteriaTypes[1].level,
                                   name: transformerName,
                                   rank: criteriaTypes[4].level,
                                   skill: criteriaTypes[7].level,
                                   speed: criteriaTypes[2].level,
                                   strength: criteriaTypes[0].level,
                                   team: team.rawValue,
                                   team_icon: "")
                
        APIManager.shared.addNew(transformer: newRobot, completion: { result in
            completion(result)
        })
    
    }
    
}
