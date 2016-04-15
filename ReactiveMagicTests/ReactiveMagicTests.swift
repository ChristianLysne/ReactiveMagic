//
//  ReactiveMagicTests.swift
//  ReactiveMagicTests
//
//  Created by Christian Lysne on 15.04.2016.
//  Copyright © 2016 NRK. All rights reserved.
//

import XCTest
import RxSwift
@testable import ReactiveMagic


class ReactiveMagicTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieService() {
        
        let expectation = expectationWithDescription("Get Movie Count")
        
        let movieService = MovieService()
        let numberOfMovies = movieService.searchMovies("a")
        
        var retrievedMovieCount = 0
        let _ = numberOfMovies.subscribeNext { (movieCount: Int) in
            retrievedMovieCount = movieCount
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertTrue(retrievedMovieCount > 0)
        })
    }
    
}
