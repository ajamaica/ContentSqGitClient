
//
//  GitHub_ClientUITests.swift
//  GitHub ClientUITests
//
//  Created by Arturo Jamaica Garcia on 23/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import XCTest

class GitHub_ClientUITests: XCTestCase {
        
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
    
    
    func testSearch(){
        
    
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("jquer")
        sleep(5)
        XCTAssert(tablesQuery.staticTexts["jquery"].exists)

    }
    
    func testSeeCommits() {

        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier:"grit").staticTexts["mojombo"].tap()
        tablesQuery.staticTexts["Commits"].tap()
        
    }
    
    
    func testSeeIssues() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier:"grit").staticTexts["mojombo"].tap()
        tablesQuery.staticTexts["Issues"].tap()

        
    }
    
    func testSeePull() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier:"grit").staticTexts["mojombo"].tap()
        tablesQuery.staticTexts["Open Pull Request"].tap()
        
        
    }
    
    func testSeeBranches() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier:"grit").staticTexts["mojombo"].tap()
        tablesQuery.staticTexts["Branches"].tap()

        
    }
    
    
}
