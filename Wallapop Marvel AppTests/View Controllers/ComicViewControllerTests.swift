//
//  ComicViewControllerTests.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 05/06/2022.
//

import XCTest
@testable import Wallapop_Marvel_App

class ComicViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: HomeViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "homeVC") as HomeViewController
        sut.loadViewIfNeeded()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    
    func testViewController_WhenCreated_HasBtnToOpenSearchContainerAndAction() throws {
        // Arrange
        let openSearchBtn: UIButton = try XCTUnwrap(sut.openSearchBtn, "Grid layout button does not have a referencing outlet")

        // Act
        let openSearchBtnAction = try XCTUnwrap(openSearchBtn.actions(forTarget: sut, forControlEvent: .touchUpInside), "Grid button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(openSearchBtnAction.count, 1)
        XCTAssertEqual(openSearchBtnAction.first, "toggleSeachBarBox:", "There is no action with a name toggleListGridView assigned to grid button")

    }

    
    func testHomeViewController_WhenCreated_HasRequiredSearchTextField() throws {
        // Arrange
        let searchTextField = try XCTUnwrap(sut.searchTextField, "The searchTextField is not connected to an IBOutlet")

        // Assert
        XCTAssertEqual(searchTextField.text, "", "search Text Field was not empty when the view controller initially loaded")
    }
    func testViewController_WhenCreated_HasRequiredSearchContainerHeightConstraint() throws {
        // Arrange
        let searchContainerHeightConstraint = try XCTUnwrap(sut.searchHeightCons, "The search Container Height Constraint is not connected to an IBOutlet")
       
        // Assert
        XCTAssertEqual(searchContainerHeightConstraint.constant, 0, "search Container Height Constraint was not empty when the view controller initially loaded")

    }
    func testViewController_WhenCreated_HasGridLayoutButtonAndAction() throws {
        // Arrange
        let gridButton: UIButton = try XCTUnwrap(sut.gridBtn, "Grid layout button does not have a referencing outlet")

        // Act
        let gridButtonActions = try XCTUnwrap(gridButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Grid button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(gridButtonActions.count, 1)
        XCTAssertEqual(gridButtonActions.first, "toggleListGridView:", "There is no action with a name toggleListGridView assigned to grid button")

    }
    func testViewController_WhenCreated_HasListLayoutButtonAndAction() throws {
        // Arrange
        let listButton: UIButton = try XCTUnwrap(sut.listBtn, "List layout button does not have a referencing outlet")

        // Act
        let listButtonActions = try XCTUnwrap(listButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "List button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(listButtonActions.count, 1)
        XCTAssertEqual(listButtonActions.first, "toggleListGridView:", "There is no action with a name toggleListGridView assigned to list button")
    }

    func testHomeViewController_WhenCreated_HasRequiredTableViewAndCollectionView() throws {
        // Arrange
        let tableV = try XCTUnwrap(sut.tableView, "The TableView is not connected to an IBOutlet")
        let collectionV = try XCTUnwrap(sut.collectionView, "The CollectionView is not connected to an IBOutlet")

        // Assert
        XCTAssertEqual(tableV.numberOfRows(inSection: 0), 0, "TableView was not empty when the view controller initially loaded")
        XCTAssertEqual(collectionV.numberOfItems(inSection: 0), 0, "CollectionView was not empty when the view controller initially loaded")
    }
    func testHomeViewController_WhenCreated_HasRequiredNoResultsLabel() throws {
        // Arrange
        let noResultsLabel = try XCTUnwrap(sut.noResultsLabel, "The Empty Results Label is not connected to an IBOutlet")
        // Assert
        XCTAssertEqual(noResultsLabel.text, "There is no results.", "Empty Results Label was loaded when the view controller initially loaded")
    }
    func testHomeViewController_segue(){
        // Assert
        sut.performSegue(withIdentifier: Constants.viewComicSegue, sender: self)
    }
}
