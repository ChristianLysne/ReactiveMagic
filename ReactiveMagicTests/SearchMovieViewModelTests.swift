//
//  SearchMovieViewModelTests.swift
//  ReactiveMagic
//
//  Created by Christian Lysne on 15.04.2016.
//  Copyright © 2016 NRK. All rights reserved.
//

import XCTest
import RxSwift
@testable import ReactiveMagic


class SearchMovieViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchMovieViewModelWithEmptySearchStringReturnsZero() {
        
        let expectation = expectationWithDescription("Get Movie Count String")
        
        class AlwaysReturn1MovieService: MovieService {
            private func searchMovies(searchText: String) -> Observable<Int> {
                return Observable.create({ (observer) -> Disposable in
                    
                    let cancel = AnonymousDisposable {
                    }
                    
                    observer.on(.Next(1))
                    observer.onCompleted()
                    
                    return cancel
                })
            }
        }
        
        let alwaysReturn1MovieService = AlwaysReturn1MovieService()
        let searchMovieViewModel = SearchMovieViewModel(movieService: alwaysReturn1MovieService)
        let numberOfMoviesString = searchMovieViewModel.searchMovies("")
        
        var retrievedMovieCountString = ""
        let _ = numberOfMoviesString.subscribeNext { (movieCount: String) in
            retrievedMovieCountString = movieCount
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertEqual(retrievedMovieCountString, "1")
        })
    }
}