//
//  TheWeatherAppUITests.swift
//  TheWeatherAppUITests
//
//  Created by Oluwakamiye Akindele on 22/06/2022.
//

import XCTest

class TheWeatherAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSavedCityTapped() {
        let toolbar = app.toolbars["Toolbar"]
        toolbar.children(matching: .other).element.children(matching: .other).element.tap()
        toolbar.buttons["List"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Ondo"]/*[[".cells.staticTexts[\"Ondo\"]",".staticTexts[\"Ondo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0)/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }
    
    func testRemoveSavedCityTapped() {
        let toolbar = app.toolbars["Toolbar"]
        toolbar.children(matching: .other).element.children(matching: .other).element.tap()
        toolbar.buttons["List"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Ondo"]/*[[".cells.staticTexts[\"Ondo\"]",".staticTexts[\"Ondo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0)/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let elementsQuery = app.scrollViews.otherElements
        let addCityButton = elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Add City"]/*[[".buttons[\"Add City\"].staticTexts[\"Add City\"]",".staticTexts[\"Add City\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let removeCityButton = elementsQuery.staticTexts["Remove City"]
        
        XCTAssertTrue(removeCityButton.exists)
        XCTAssertFalse(addCityButton.exists)
        removeCityButton.tap()
        XCTAssertTrue(addCityButton.exists)
        XCTAssertFalse(removeCityButton.exists)
    }
    
    func testSearchedCityTapped() {
        let toolbar = app.toolbars["Toolbar"]
        toolbar.children(matching: .other).element.children(matching: .other).element.tap()
        toolbar.buttons["Search"].tap()
        app.tables["Empty list"].searchFields["Search for a city"].tap()
        
        let oKey = app.keys["O"]
        oKey.tap()
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        let oKey2 = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey2.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Nigeria"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let addCityButton = elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Add City"]/*[[".buttons[\"Add City\"].staticTexts[\"Add City\"]",".staticTexts[\"Add City\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let removeCityButton = elementsQuery.staticTexts["Remove City"]
        
        if addCityButton.exists {
            addCityButton.tap()
            XCTAssertTrue(removeCityButton.exists)
            XCTAssertFalse(addCityButton.exists)
        } else if removeCityButton.exists {
            removeCityButton.tap()
            XCTAssertTrue(addCityButton.exists)
            XCTAssertFalse(removeCityButton.exists)
        }
    }
}
