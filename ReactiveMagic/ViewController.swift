//
//  ViewController.swift
//  ReactiveMagic
//
//  Created by Christian Lysne on 15.04.2016.
//  Copyright © 2016 NRK. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var movieSearchTextField: UITextField!
    @IBOutlet weak var movieCountLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    private let searchMovieViewModel: SearchMovieViewModel = SearchMovieViewModel(movieService: HardcodedMovieService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchTextField.rx_text
            .flatMapLatest { query in
                self.searchMovieViewModel.searchMovies(query)
            }
            .bindTo(self.movieCountLabel.rx_text)
            .addDisposableTo(self.disposeBag)
    }
    
    //MARK: IBActions
    @IBAction func movieSearchTextFieldValueChanged(sender: AnyObject) {
        
    }
}

