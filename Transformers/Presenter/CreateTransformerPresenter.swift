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
    
    var team: Team = .autobots
    
    var criteriaTypes:[RobotCriteria] = [RobotCriteria(criteria: .strength, level: 1),
                                          RobotCriteria(criteria: .interlligence, level: 1),
                                          RobotCriteria(criteria: .speed, level: 1),
                                          RobotCriteria(criteria: .endurance, level: 1),
                                          RobotCriteria(criteria: .rank, level: 1),
                                          RobotCriteria(criteria: .courage, level: 1),
                                          RobotCriteria(criteria: .firepower, level: 1),
                                          RobotCriteria(criteria: .skill, level: 1)
                                            ]
    
    func addNew(transformerName: String, completion: @escaping ((Result<Transformer, Error>)) -> Void) {
        
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
