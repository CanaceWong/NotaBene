//
//  NotaBeneUITests.swift
//  NotaBeneUITests
//
//  Created by Olivia Beresford on 05/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import XCTest

class NotaBeneUITests: XCTestCase {
    
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
    
    func testExample() {
        
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "exists == 1")
        let entryTab = app.navigationBars["Entries"]
        let logInButton = app.buttons["Log in"]
        logInButton.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("notabene@team.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing565656")
        logInButton.tap()
        
        XCTAssert(app.alerts["Error"].exists)
        app.alerts["Error"].buttons["OK"].tap()
        
        passwordSecureTextField.typeText("testing")
        logInButton.tap()
        
        expectation(for: predicate, evaluatedWith: entryTab, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(app.navigationBars["Entries"].exists)
        
        let entriesNavigationBar = app.navigationBars["Entries"]
        entriesNavigationBar.buttons["Add"].tap()
        
        let entrytitleTextField = app/*@START_MENU_TOKEN@*/.textFields["entryTitle"]/*[[".textFields[\"entry title\"]",".textFields[\"entryTitle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        entrytitleTextField.tap()
        entrytitleTextField.typeText("hello again")
        
        let entrycontentTextField = app/*@START_MENU_TOKEN@*/.textFields["entryContent"]/*[[".textFields[\"entry content.....\"]",".textFields[\"entryContent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        entrycontentTextField.tap()
        entrycontentTextField.typeText("hello again")
        app/*@START_MENU_TOKEN@*/.buttons["saveEntry"]/*[[".buttons[\"Save\"]",".buttons[\"saveEntry\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.staticTexts["hello again"].exists)

        
        
        
    }
        
}
