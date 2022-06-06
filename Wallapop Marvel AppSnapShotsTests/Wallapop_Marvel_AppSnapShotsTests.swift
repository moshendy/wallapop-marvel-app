//
//  Wallapop_Marvel_AppSnapShotsTests.swift
//  Wallapop Marvel AppSnapShotsTests
//
//  Created by Mohamed Shendy on 06/06/2022.
//

import XCTest
import SnapshotTesting

@testable import Wallapop_Marvel_App

class Wallapop_Marvel_AppSnapShotsTests: XCTestCase {
    
    var waiter = XCTWaiter()
    var homeVC : HomeViewController!
    var splashVC : SplashViewController!
    var viewComicVC : ComicViewController!
    var storyBoard : UIStoryboard!

    override func setUpWithError() throws {

        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        homeVC = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        homeVC.loadViewIfNeeded()
        
        splashVC = storyBoard.instantiateViewController(withIdentifier: "splashVC") as! SplashViewController
        splashVC.loadViewIfNeeded()

        viewComicVC = storyBoard.instantiateViewController(withIdentifier: "comicVC") as! ComicViewController
        viewComicVC.loadViewIfNeeded()

    }
    override func tearDownWithError() throws {
        homeVC = nil
        viewComicVC = nil
        splashVC = nil
    }
    
    func testMyViewControllers() {
        let exp = expectation(description: "wait for view to load")
        let _ = waiter.wait(for: [exp], timeout: 8)
        assertSnapshot(matching: homeVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: homeVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: homeVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: homeVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: homeVC, as: .image(on: .iPadPro12_9(.landscape)))
        assertSnapshot(matching: homeVC, as: .image(on: .iPadPro12_9(.portrait)))


        assertSnapshot(matching: splashVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: splashVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: splashVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: splashVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: splashVC, as: .image(on: .iPadPro12_9(.landscape)))
        assertSnapshot(matching: splashVC, as: .image(on: .iPadPro12_9(.portrait)))

        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPadPro12_9(.landscape)))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPadPro12_9(.portrait)))

        waiter = XCTWaiter()
    }
    
    func testMyViewControllers_InDarkMode() {

        homeVC.overrideUserInterfaceStyle = .dark
        splashVC.overrideUserInterfaceStyle = .dark
        viewComicVC.overrideUserInterfaceStyle = .dark
        
        let exp = expectation(description: "wait for view to load")
        let _ = waiter.wait(for: [exp], timeout: 8)
        assertSnapshot(matching: homeVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: homeVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: homeVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: homeVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: homeVC, as: .image(on: .iPadPro12_9(.landscape)))
        assertSnapshot(matching: homeVC, as: .image(on: .iPadPro12_9(.portrait)))


        assertSnapshot(matching: splashVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: splashVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: splashVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: splashVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: splashVC, as: .image(on: .iPadPro12_9(.landscape)))
        assertSnapshot(matching: splashVC, as: .image(on: .iPadPro12_9(.portrait)))

        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPadPro12_9(.landscape)))
        assertSnapshot(matching: viewComicVC, as: .image(on: .iPadPro12_9(.portrait)))

        
        waiter = XCTWaiter()
    }

}
