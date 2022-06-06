//
//  MockComicsServiceTests.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 05/06/2022.
//

import XCTest
@testable import Wallapop_Marvel_App

class ComicsServiceTests: XCTestCase {
    
    var sutMock : MockComicServiceProtocol!
    
    var ComicVM : ComicsViewModel!
    var mockComicViewModel : MockComicViewModel!

    override func setUp() {
        sutMock = MockComicServiceProtocol()
        ComicVM = ComicsViewModel()
        mockComicViewModel = MockComicViewModel()
    }
    
    override func tearDown() {
        sutMock = nil
        ComicVM = nil
    }
    
    func testMockComicService_WhenResponseFail(){
        sutMock.getComics(offset: 0){ success, model, container, message in
            XCTAssertFalse(success, "Failed")
            XCTAssertEqual(message, "Error: 500", "Error: 500")
        }
    }
    func testMockComicService_WhenResponseFail2(){
        sutMock.getComics(offset: 2){ success, model, container, message in
            XCTAssertFalse(success, "Failed")
            XCTAssertEqual(message, "Error: Api Failure", "Error: Failure")
        }
    }
    func testMockComicService_WhenResponseSuccess(){
        sutMock.getComics(offset: 1){ success, model, container, message in
            if success, let comics = model, let container = container {
                self.mockComicViewModel.fetchData(comics: comics, comicDC: container)
            }
            XCTAssertTrue(success, "Success")
            XCTAssertEqual(message, "Success: 200", "Success: 200")
        }
    }
    
}
