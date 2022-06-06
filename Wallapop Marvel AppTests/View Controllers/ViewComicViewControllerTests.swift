//
//  ViewComicViewControllerTests.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 05/06/2022.
//

import XCTest
@testable import Wallapop_Marvel_App

class ViewComicViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: ComicViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "comicVC") as ComicViewController
        sut.loadViewIfNeeded()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    func testComicViewController_WhenCreated_HasRequiredLabels() throws {
        // Arrange
        let comicLabel = try XCTUnwrap(sut.comicLabel, "The comic Label is not connected to an IBOutlet")
        let comicDescriptionLabel = try XCTUnwrap(sut.comicDescriptionLabel, "The comic Description Label is not connected to an IBOutlet")
        let priceLabel = try XCTUnwrap(sut.priceLabel, "The price Label is not connected to an IBOutlet")
        let formatLabel = try XCTUnwrap(sut.formatLabel, "The format Label is not connected to an IBOutlet")
        let publishedDateLabel = try XCTUnwrap(sut.publishedDateLabel, "The published Date Label is not connected to an IBOutlet")
        let focDateLabel = try XCTUnwrap(sut.focDateLabel, "The focDate Label is not connected to an IBOutlet")
        let comicImage = try XCTUnwrap(sut.comicImage, "The comic Image is not connected to an IBOutlet")

        // Assert
        XCTAssertEqual(comicLabel.text, "Label", "comic Label was not empty when the view controller initially loaded")
        XCTAssertEqual(comicDescriptionLabel.text, "Label", "comic Description Label was not empty when the view controller initially loaded")
        XCTAssertEqual(priceLabel.text, "Label", "price Label was not empty when the view controller initially loaded")
        XCTAssertEqual(formatLabel.text, "Label", "format Label was not empty when the view controller initially loaded")
        XCTAssertEqual(publishedDateLabel.text, "Label", "published Date Label was not empty when the view controller initially loaded")
        XCTAssertEqual(focDateLabel.text, "Label", "focDate Label was not empty when the view controller initially loaded")
        XCTAssertEqual(comicImage.tag, 1, "comic Image was not empty when the view controller initially loaded")
    }

}
