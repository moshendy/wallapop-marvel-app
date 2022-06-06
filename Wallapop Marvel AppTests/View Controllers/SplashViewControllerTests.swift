//
//  SplashViewControllerTests.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 05/06/2022.
//

import XCTest
@testable import Wallapop_Marvel_App

class SplashViewControllerTests: XCTestCase {
    
    
    var storyboard: UIStoryboard!
    var sut: SplashViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "splashVC") as SplashViewController
        sut.loadViewIfNeeded()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    func testSplashViewController_WhenCreated_HasRequiredLogo() throws {
        // Arrange
        let logo = try XCTUnwrap(sut.logo, "The logo is not connected to an IBOutlet")
        
        // Assert
        XCTAssertEqual(logo.tag, 1, "logo was not empty when the view controller initially loaded")
    }
    
    func testSplashViewController_segue(){
        // Assert
        sut.performSegue(withIdentifier: Constants.homeSegue, sender: self)
    }
    
}
