//
//  HueBridgeServiceTests.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import LightHouse

class HueBridgeServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetStatus() {
        let expectation = expectationWithDescription("SomeService does stuff and runs the callback closure");
        
        HueBridgeService.singleton.getSystemState({ (lightArray: Array<Light>) ->() in
            print("data received!");
            expectation.fulfill();
        });
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }


}
