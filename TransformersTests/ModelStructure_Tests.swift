//
//  ModelStructure_Tests.swift
//  TransformersTests
//
//  Created by Jasur Rajabov on 4/24/21.
//

import XCTest
@testable import Transformers

class ModelStructure_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CriteriaStructure() {
        let testCriteria = RobotCriteria(criteria: .speed, level: 5)
        
        XCTAssertNotNil(testCriteria)
        XCTAssertEqual(testCriteria.criteria.rawValue, "Speed")
        XCTAssertEqual(testCriteria.level, 5)
    }
    
    func test_CriteriaType() {
        let testCriteriaType0 = CriteriaType.strength
        let testCriteriaType1 = CriteriaType.interlligence
        let testCriteriaType2 = CriteriaType.speed
        let testCriteriaType3 = CriteriaType.endurance
        let testCriteriaType4 = CriteriaType.rank
        let testCriteriaType5 = CriteriaType.courage
        let testCriteriaType6 = CriteriaType.firepower
        let testCriteriaType7 = CriteriaType.skill
        
        XCTAssertNotNil(testCriteriaType0)
        XCTAssertEqual(testCriteriaType0.rawValue, "Strength")
        XCTAssertEqual(testCriteriaType1.rawValue, "Intelligence")
        XCTAssertEqual(testCriteriaType2.rawValue, "Speed")
        XCTAssertEqual(testCriteriaType3.rawValue, "Endurance")
        XCTAssertEqual(testCriteriaType4.rawValue, "Rank")
        XCTAssertEqual(testCriteriaType5.rawValue, "Courage")
        XCTAssertEqual(testCriteriaType6.rawValue, "Firepower")
        XCTAssertEqual(testCriteriaType7.rawValue, "Skill")
        
    }

}
