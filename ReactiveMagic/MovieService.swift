//
//  MovieService.swift
//  ReactiveMagic
//
//  Created by Christian Lysne on 15.04.2016.
//  Copyright © 2016 NRK. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieService {
    func searchMovies(searchText: String) -> Observable<Int>
}

class HardcodedMovieService: MovieService {
    
    private let urlSession = NSURLSession.sharedSession()
    
    func searchMovies(searchText: String) -> Observable<Int> {
        return Observable.create({ (observer) -> Disposable in
            
            let urlRequest = NSURLRequest(URL: NSURL(string: "http://www.imdb.com")!)
            
            let task = self.urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) in
                guard let response = response, _ = data else {
                    observer.on(.Error(error ?? RxCocoaURLError.Unknown))
                    return
                }
                
                guard let _ = response as? NSHTTPURLResponse else {
                    observer.on(.Error(RxCocoaURLError.NonHTTPResponse(response: response)))
                    return
                }
                
//                observer.on(.Next(data, httpResponse))
                observer.onNext(Int(arc4random()%100))
                observer.on(.Completed)
            }
            
            task.resume()
            
            return AnonymousDisposable {
                task.cancel()
            }
        })
    }
}

