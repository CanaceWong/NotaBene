//
//  loginTests.swift
//  NotaBeneUITests
//
//  Created by Canace Lok Hay Wong on 06/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import XCTest
import UIKit
import FirebaseAuth
import FirebaseDatabase



class RegisterViewController: XCTestCase {
    
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
    
    func testUserSignUpWithIncorrectUserName() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let predicate = NSPredicate(format: "exists == 1")
        let entryTab = app.alerts["Error"]
        
        
        app/*@START_MENU_TOKEN@*/.buttons["Register"]/*[[".otherElements[\"Home\"].buttons[\"Register\"]",".buttons[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailtextTextField = app.textFields["emailText"]
        emailtextTextField.tap()
        emailtextTextField.typeText("wrong")
        
        let passwordtextSecureTextField = app.secureTextFields["passwordText"]
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("testing")
        
        app.buttons["Sign Up"].tap()
        
        expectation(for: predicate, evaluatedWith: entryTab, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(app.alerts["Error"].exists)

    }
    
    func testUserSignUpWithIncorrectPassword() {
        
        let predicate = NSPredicate(format: "exists == 1")
        let signinError = app.alerts["Error"]
        
        
        app/*@START_MENU_TOKEN@*/.buttons["Register"]/*[[".otherElements[\"Home\"].buttons[\"Register\"]",".buttons[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailtextTextField = app.textFields["emailText"]
        emailtextTextField.tap()
        emailtextTextField.typeText("testing@testing.com")
        
        let passwordtextSecureTextField = app.secureTextFields["passwordText"]
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("wrong")
        
        app.buttons["Sign Up"].tap()
        
        expectation(for: predicate, evaluatedWith: signinError, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(app.alerts["Error"].exists)
        
    }
    
    func testSuccessfulsignupGoesToSigninPage() {
        
        app/*@START_MENU_TOKEN@*/.buttons["Register"]/*[[".otherElements[\"Home\"].buttons[\"Register\"]",".buttons[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailtextTextField = app.textFields["emailText"]
        emailtextTextField.tap()
        app.textFields["emailText"].typeText("thisiscorrectagaintesting@testing.com")
        
        let passwordtextSecureTextField = app.secureTextFields["passwordText"]
        passwordtextSecureTextField.tap()
        passwordtextSecureTextField.typeText("testing")
        app.buttons["Sign Up"].tap()
        app.alerts["You have signed up successfully!"].buttons["Ok"].tap()
        
        XCTAssert(app.buttons["Log in"].exists)
        
    }


    
}

