//
//  NotaBeneUITests.swift
//  NotaBeneUITests
//
//  Created by Olivia Beresford on 05/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import XCTest
import FirebaseAuth
import Firebase

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


        app/*@START_MENU_TOKEN@*/.buttons["Signup"]/*[[".segmentedControls.buttons[\"Signup\"]",".buttons[\"Signup\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("testing@testing.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Testing")
        app.otherElements.containing(.textField, identifier:"Username").children(matching: .button)["Login"].tap()
        
        let entriesNavigationBar = app.navigationBars["Entries"]
        let logoutButton = entriesNavigationBar.buttons["Logout"]
        
        logoutButton.tap()
        usernameTextField.tap()
        usernameTextField.typeText("testing@testing.com")
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Testing")
        
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button)["Login"].tap()
        
        let addButton = entriesNavigationBar.buttons["Add"]
        addButton.tap()
        window.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        
        let entrytitleTextField = app/*@START_MENU_TOKEN@*/.textFields["EntryTitle"]/*[[".textFields[\"entry title\"]",".textFields[\"EntryTitle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        entrytitleTextField.tap()
        entrytitleTextField.typeText("Another test")
        
        let entrycontentTextField = app/*@START_MENU_TOKEN@*/.textFields["EntryContent"]/*[[".textFields[\"entry content.....\"]",".textFields[\"EntryContent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        entrycontentTextField.tap()
        entrycontentTextField.typeText("another test ")
        app.buttons["Save"].tap()
        addButton.tap()
        app.navigationBars["Your Entry"].buttons["Cancel"].tap()

        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                print(error.localizedDescription)
            } else {
                // Account deleted.
                print("account is deleted")
            }
        }
      

        
    }
        
}
