//
//  NotaBeneUITests.swift
//  NotaBeneUITests
//
//  Created by Olivia Beresford on 05/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import XCTest
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import BSImagePicker
import Photos
import UserNotifications


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
    
    func testCreateEntry() {
        
        app/*@START_MENU_TOKEN@*/.buttons["Log in"]/*[[".otherElements[\"Home\"].buttons[\"Log in\"]",".buttons[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("newtest@testing.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing")
        
        app.buttons["Log in"].tap()
        app.navigationBars["ENTRIES"].buttons["Add"].tap()
        
        let entrytitleTextField = app/*@START_MENU_TOKEN@*/.textFields["entryTitle"]/*[[".textFields[\"entry title\"]",".textFields[\"entryTitle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        entrytitleTextField.tap()
        entrytitleTextField.typeText("hello there")
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element

        
        let entrycontentTextField = textView
        entrycontentTextField.tap()
        entrycontentTextField.typeText("well well well")
        app/*@START_MENU_TOKEN@*/.buttons["saveEntry"]/*[[".buttons[\"Save\"]",".buttons[\"saveEntry\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.staticTexts["hello there"].exists)
        
    }
    
    func testReadEntry() {
        app.buttons["Log in"].tap()
        
        let usernameTextField = app/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".textFields[\"email...\"]",".textFields[\"Username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        usernameTextField.tap()
        usernameTextField.typeText("notabene@team.com")
        
        let passwordSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".secureTextFields[\"password...\"]",".secureTextFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing")
        app.buttons["Log in"].tap()
        
        let entriesNavigationBar = app.navigationBars["ENTRIES"]
        entriesNavigationBar.buttons["Add"].tap()
        
        let entrytitleTextField = app/*@START_MENU_TOKEN@*/.textFields["entryTitle"]/*[[".textFields[\"Title...\"]",".textFields[\"entryTitle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        entrytitleTextField.tap()
        entrytitleTextField.typeText("we will read this")
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textView = element.children(matching: .other).element.children(matching: .textView).element
        
        textView.tap()
        textView.typeText("great entry")
        app/*@START_MENU_TOKEN@*/.buttons["saveEntry"]/*[[".buttons[\"SAVE\"]",".buttons[\"saveEntry\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.staticTexts["we will read this"].tap()
        
        XCTAssert(app.textViews["entryContentEditable"].exists)

        app.buttons["DELETE"].tap()
        entriesNavigationBar/*@START_MENU_TOKEN@*/.buttons["Logout"]/*[[".buttons[\"Log out\"]",".buttons[\"Logout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
    }
    
    func testUpdateEntry() {

    }
    
    

}
