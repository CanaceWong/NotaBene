//
//  signInTests.swift
//  NotaBeneUITests
//
//  Created by Canace Lok Hay Wong on 14/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import XCTest
import UIKit
import FirebaseAuth
import FirebaseDatabase


class ViewControllerScene: XCTestCase {
    
    let app = XCUIApplication()

        
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
    
    func testWrongUsername() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let predicate = NSPredicate(format: "exists == 1")
        let signinError = app.alerts["Error"]
        
        
        app/*@START_MENU_TOKEN@*/.buttons["Log in"]/*[[".otherElements[\"Home\"].buttons[\"Log in\"]",".buttons[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("unregisteredemail@testing.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing")
        app.buttons["Log in"].tap()
        
        expectation(for: predicate, evaluatedWith: signinError, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(app.alerts["Error"].exists)

    }
    
    func testWrongPassword() {
        
        let predicate = NSPredicate(format: "exists == 1")
        let signinError = app.alerts["Error"]
        
        
        app/*@START_MENU_TOKEN@*/.buttons["Log in"]/*[[".otherElements[\"Home\"].buttons[\"Log in\"]",".buttons[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("unregisteredemail@testing.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing")
        app.buttons["Log in"].tap()
        
        expectation(for: predicate, evaluatedWith: signinError, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(app.alerts["Error"].exists)
    }
    
    func testRightUsernameandPassword() {
        
        let predicate = NSPredicate(format: "exists == 1")
        let entryTab = app.navigationBars["ENTRIES"]
        
        app/*@START_MENU_TOKEN@*/.buttons["Log in"]/*[[".otherElements[\"Home\"].buttons[\"Log in\"]",".buttons[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("notabene@team.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing")
        app.buttons["Log in"].tap()
        
        expectation(for: predicate, evaluatedWith: entryTab, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        XCTAssert(app.navigationBars["ENTRIES"].exists)
        
        
        
    }

    
    

    
}
