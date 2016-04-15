//
//  MovieService.swift
//  ReactiveMagic
//
//  Created by Christian Lysne on 15.04.2016.
//  Copyright © 2016 NRK. All rights reserved.
//

import Foundation
import RxSwift

class MovieService {
    func searchMovies(searchText: String) -> Observable<Int> {
        return Observable.create({ (observer) -> Disposable in
            
            let cancel = AnonymousDisposable {
            }
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(4 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue(), {
                if cancel.disposed {
                    return
                }
                observer.on(.Next(1))
                observer.onCompleted()
            })
            
            return cancel
        })
    }
}