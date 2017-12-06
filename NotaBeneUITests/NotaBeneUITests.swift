//
//  NotaBeneUITests.swift
//  NotaBeneUITests
//
//  Created by Olivia Beresford on 05/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import XCTest

class NotaBeneUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
      
        
        let app = XCUIApplication()
        
        let predicate = NSPredicate(format: "exists == 1")
        let entryTab = app.navigationBars["Entries"]

     

        
        XCTAssertFalse(entryTab.exists)
        

        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("canacewong@testing.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Testing")
        app.otherElements.containing(.textField, identifier:"Username").children(matching: .button)["Login"].tap()
        
        expectation(for: predicate, evaluatedWith: entryTab, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(app.navigationBars["Entries"].exists)
        
            
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func codeTest() {
        
        
    }
    
}
