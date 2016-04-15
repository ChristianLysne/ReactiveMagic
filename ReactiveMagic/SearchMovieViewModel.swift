//
//  SearchMovieViewModel.swift
//  ReactiveMagic
//
//  Created by Christian Lysne on 15.04.2016.
//  Copyright © 2016 NRK. All rights reserved.
//

import Foundation
import RxSwift

class SearchMovieViewModel {
    
    private let movieService: MovieService
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
 
    func searchMovies(searchText: String) -> Observable<String> {
        return self.movieService.searchMovies(searchText)
            .observeOn(MainScheduler.instance)
            .map{String($0)}
    }
}