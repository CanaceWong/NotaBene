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
        let registerButton = app.buttons["Register"]
        registerButton.tap()
        
        let emailtextTextField = app.textFields["emailText"]
        emailtextTextField.tap()
        emailtextTextField.tap()
        emailtextTextField.typeText("test@testagain.com")
        
        let passwordtextSecureTextField = app.secureTextFields["passwordText"]
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("testing")
        
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        
        let okButton = app.alerts["Error"].buttons["OK"]
        okButton.tap()
        passwordtextSecureTextField.swipeLeft()
        emailtextTextField.swipeLeft()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeRight()
        emailtextTextField.typeText("maggie@tests.com")
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("testing")
        signUpButton.tap()
        okButton.tap()
        passwordtextSecureTextField.swipeLeft()
        emailtextTextField.swipeLeft()
        emailtextTextField.tap()
        emailtextTextField.tap()
        emailtextTextField.tap()
        emailtextTextField.tap()
        emailtextTextField.tap()
        emailtextTextField.tap()
        
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
        
        let logInButton = app.buttons["Log in"]
        logInButton.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("chaya@tests.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testing")
        logInButton.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["entryTitleLabel"]/*[[".cells",".staticTexts[\"Test 1\"]",".staticTexts[\"entryTitleLabel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["“NotaBene” Would Like to Send You Notifications"].buttons["Allow"].tap()
        
        let entrycontenteditableTextView = app.textViews["entryContentEditable"]
        entrycontenteditableTextView.tap()
        entrycontenteditableTextView.typeText("again")
        app/*@START_MENU_TOKEN@*/.buttons["saveChanges"]/*[[".buttons[\"Save Changes\"]",".buttons[\"saveChanges\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Entries"].buttons["Logout"].tap()
        registerButton.tap()
        emailtextTextField.tap()
        emailtextTextField.typeText("hello@testagain.com")
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("testingisfun")
        signUpButton.tap()
        okButton.tap()
        cancelButton.tap()
        
        let app = XCUIApplication()
        app.buttons["Register"].tap()
        
        let emailtextTextField = app.textFields["emailText"]
        emailtextTextField.tap()
        emailtextTextField.typeText("oranges@christmas.com")
        
        let passwordtextSecureTextField = app.secureTextFields["passwordText"]
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("testing")
        app.buttons["Sign Up"].tap()
        app.alerts["Error"].buttons["OK"].tap()
        
        
    }
        
}
