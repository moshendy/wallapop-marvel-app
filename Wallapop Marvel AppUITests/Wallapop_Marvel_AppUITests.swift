//
//  Wallapop_Marvel_AppUITests.swift
//  Wallapop Marvel AppUITests
//
//  Created by Mohamed Shendy on 05/06/2022.
//

import XCTest

class Wallapop_Marvel_AppUITests: XCTestCase {

    private var app: XCUIApplication!
    private var searchTextField: XCUIElement!
    private var openSearchBtn: XCUIElement!
    private var searchActionBtn: XCUIElement!
    private var listViewBtn: XCUIElement!
    private var gridViewBtn: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()

        searchTextField = app.textFields["Search for comics"]
        openSearchBtn = app.buttons["Search"]
        searchActionBtn = app.buttons["searchActionBtn"]
        
        listViewBtn = app.buttons["list.bullet.rectangle"]
        gridViewBtn = app.buttons["Grid view"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        searchTextField = nil
        openSearchBtn = nil
        searchActionBtn = nil
        listViewBtn = nil
        gridViewBtn = nil

    }


    func testHomeViewController_WhenViewLoaded_OpenSearchContainerAndSearchWithoutTypying() throws {
                
        try testHomeViewController_WhenViewLoaded_ClickOnSearchBtnToShowSearchTextField()

        if searchTextField.waitForExistence(timeout: 2){
            searchTextField.tap()
            searchActionBtn.tap()
            XCTAssertTrue(searchTextField.isEnabled, "Search UITextField is not enabled for user interactions")
        }else{
            XCTFail("OpenSearchContainerAndSearchWithoutTypying")
            return
        }
    }
    
    func testHomeViewController_WhenViewLoaded_OpenSearchContainerAndSearchWithTypying() throws {
                
        try testHomeViewController_WhenViewLoaded_ClickOnSearchBtnToShowSearchTextField()

        if searchTextField.waitForExistence(timeout: 2){
            searchTextField.tap()
            searchTextField.typeText("avengers")
            searchActionBtn.tap()
            XCTAssertTrue(searchActionBtn.isEnabled, "Search UITextField is not enabled for user interactions")
        }else{
            XCTFail("OpenSearchContainerAndSearchWithTypying")
            return
        }
    }
    
    func testHomeViewController_WhenViewLoaded_ToggleViewOfListing() throws {
   
        if gridViewBtn.waitForExistence(timeout: 2){
            gridViewBtn.tap()
        }else{
            XCTFail("ToggleViewOfListing Grid View")
            return
        }

        if listViewBtn.waitForExistence(timeout: 2){
            listViewBtn.tap()
        }else{
            XCTFail("ToggleViewOfListing List View")
            return
        }
    }


    func testHomeViewController_WhenViewLoaded_ClickOnSearchBtnToShowSearchTextField() throws {
        openSearchBtn.tap()
    }
    
    
    func testHomeViewController_WhenViewLoaded_ClickOnTableViewCell() throws {
        if app.tables.element(boundBy: 0).cells.element(boundBy: 0).waitForExistence(timeout: 5){
            app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        }else{
            XCTFail("ClickOnTableViewCell")
            return
        }
    }
    func testHomeViewController_WhenViewLoaded_ClickOnCollectionViewCell() throws {
        if gridViewBtn.waitForExistence(timeout: 2){
            gridViewBtn.tap()
            if app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).waitForExistence(timeout: 5){
                app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
            }else{
                XCTFail("ClickOnCollectionViewCell Failed Here")
                return
            }

        }else{
            XCTFail("ClickOnCollectionViewCell Failed Here 2")
            return
        }

    }

    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
