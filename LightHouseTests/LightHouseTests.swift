//
//  LightHouseTests.swift
//  LightHouseTests
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import XCTest
@testable import LightHouse

class LightHouseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEventBus() {
        var wasCalled: Bool = false;
        
        let callbackId = EventBus.bus.register("test1", callback: { (data: AnyObject) -> Void in
            guard let data = data as? [String:AnyObject] else{ return }
            wasCalled = true;
            guard let value = data["myKey"] as? Int else {return};
            XCTAssert(value == 123)
            
        });
        
        EventBus.bus.notify("test1", data:["myKey": 123]);
        
        XCTAssert(wasCalled == true);
        
        wasCalled = false;
        EventBus.bus.unregister(callbackId);
        EventBus.bus.notify("test1", data:["myKey": 123]);
        XCTAssert(wasCalled == false);
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
