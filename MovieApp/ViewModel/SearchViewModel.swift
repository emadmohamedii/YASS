//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Emad Habib on 10/20/20.
//  Copyright © 2020 MAC240. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import CoreData

final class SearchViewModel: BaseViewModel {
    
    // Dependencies
    private let dependencies: Dependencies
    var managedObjectContext: NSManagedObjectContext!
    
    /// Network request in progress
    let isLoading: ActivityIndicator =  ActivityIndicator()
    
    //API Result
    var getMoviesData: Observable<APIResult<GetMovieResponse>> {
        return _getMoviesData.asObservable().observeOn(MainScheduler.instance)
    }
    private let _getMoviesData = ReplaySubject<APIResult<GetMovieResponse>>.create(bufferSize: 1)
    
    //Data
    var movieTableData: Observable<[Movie]>
    var movies: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    let selectedMovie = PublishSubject<Movie?>()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.movieTableData = movies.asObservable()
        super.init()
        
        getMovies()
        
        getMoviesData
            .subscribe(onNext: { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .success(let response):
                    if response.results != nil {
                        self.movies.accept(response.results ?? [])
                    }
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}


//MARK:- API Call
extension SearchViewModel {
    
    func getMovies() {
        let parameter = [
            Params.apiKey.rawValue : Environment.MOVIEDB_APIKEY()
        ] as [String : Any]
        
        dependencies.api.getMovieList(param: parameter)
            .trackActivity(self.isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let v):
                        self._getMoviesData.on(event)
                        if let data = v.results , data.count == 0 {
                            self.alertDialog.onNext(("Warning", "No results found"))
                        }
                    case .failure(let error):
                        // Fetch data from local cache when internet is not available
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            self.alertDialog.onNext((NSLocalizedString("Network error", comment: ""), error.message))
                        } else {
                            self.alertDialog.onNext(("Error", error.message))
                        }
                    }
                    
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
}
