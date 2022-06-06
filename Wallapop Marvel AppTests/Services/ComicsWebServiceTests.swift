//
//  ComicsWebServiceTests.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 06/06/2022.
//
import XCTest
@testable import Wallapop_Marvel_App

class ComicsWebServiceTests: XCTestCase {
    
    var sutWeb : MockWebService!
    var mockComicViewModel : MockComicViewModel!

    override func setUp() {
        mockComicViewModel = MockComicViewModel()
        sutWeb = MockWebService()
    }
    
    override func tearDown() {
        mockComicViewModel = nil
        sutWeb = nil
    }
    
    
    func testMockWebService_WhenResponseSuccess(){
        let e = expectation(description: "Alamofire")

        sutWeb.getComics(offset: 0){ success, model, container, message in
            if success, let comics = model, let container = container {
                self.mockComicViewModel.fetchData(comics: comics, comicDC: container)
                e.fulfill()
                XCTAssertEqual(comics.count, 25, "Success: comics count")
            }
            XCTAssertTrue(success, "Success")
            XCTAssertEqual(message, "Success: 200", "Success")
        }
        
        waitForExpectations(timeout: 30, handler: nil)

    }
    
    func testMockWebServiceWithTitleParameter_WhenResponseSuccess(){
        let e = expectation(description: "Alamofire")

        sutWeb.getComicsByTitle(offset: 0,title: "spider"){ success, model, container, message in
            if success, let comics = model, let container = container {
                self.mockComicViewModel.fetchData(comics: comics, comicDC: container)
                e.fulfill()
                XCTAssertEqual(comics.count, 25, "Success: comics count")
            }
            XCTAssertTrue(success, "Success")
            XCTAssertEqual(message, "Success: 200", "Success")
        }
        
        waitForExpectations(timeout: 10, handler: nil)

    }
    func testMockWebServiceWithTitleParameter_WhenResponseFailed(){
        let e = expectation(description: "Alamofire")

        sutWeb.getComicsByTitle(offset: 0,title: ""){ success, model, container, message in
            if success, let comics = model, let container = container {
                self.mockComicViewModel.fetchData(comics: comics, comicDC: container)
                e.fulfill()
                XCTAssertEqual(comics.count, 25, "Success: comics count")
            }else{
                e.fulfill()
                XCTAssertFalse(success, "Success")
                XCTAssertEqual(message, "Error: Api Failure", "Success")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)

    }

}
