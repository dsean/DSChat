//
//  chatTests.swift
//  chatTests
//
//  Created by 楊德忻 on 2018/1/26.
//  Copyright © 2018年 sean. All rights reserved.
//

import XCTest
@testable import chat

class chatTests: XCTestCase {
    
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCheckPassword() {
        XCTAssertTrue(Utilities.checkPassword(password:"abtZsq"))
        XCTAssertTrue(Utilities.checkPassword(password:"123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkPassword(password:"0123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkPassword(password:"123"))
        XCTAssertFalse(Utilities.checkPassword(password:"!~#+"))
    }
    
    func testCheckUsername() {
        XCTAssertTrue(Utilities.checkUsername(username: "一"))
        XCTAssertTrue(Utilities.checkUsername(username: "123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkUsername(username: "123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkUsername(username: ""))
        XCTAssertFalse(Utilities.checkUsername(username: "!~#+"))
    }
}
