
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Emad Habib on 05/12/2020.
//  Copyright © 2020 MAC240. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import CoreData

final class MovieDetailViewModel: BaseViewModel {
    typealias Dependencies = HasAPI
    
    // Dependencies
    private let dependencies: Dependencies
    
    var movies = [Movie]()
    
    /// Network request in progress
    let isLoading: ActivityIndicator =  ActivityIndicator()
    
    //API Result
    var getMoviesDetailData: Observable<APIResult<GetMovieDetailResponse>> {
        return _getMoviesDetailData.asObservable().observeOn(MainScheduler.instance)
    }
    private let _getMoviesDetailData = ReplaySubject<APIResult<GetMovieDetailResponse>>.create(bufferSize: 1)
    
    //Data
    var selectedMovie: Movie?
    var movieDetailResponse:  BehaviorRelay<GetMovieDetailResponse?> = BehaviorRelay<GetMovieDetailResponse?>(value: nil)
    var tableData:  BehaviorRelay<[MovieDetailsViewController.TableData]>  = BehaviorRelay<[MovieDetailsViewController.TableData]>(value: [])
    
    //Custom method
    var popToMovieList = PublishSubject<Void>()
    
    
    init(dependencies: Dependencies,movie: Movie){
        self.dependencies = dependencies
        self.selectedMovie = movie
        super.init()
        
        getMoviesDetailData
            .subscribe(onNext: { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .success(let response):
                    self.movieDetailResponse.accept(response.responseModel)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
}



//MARK:- API Call
extension MovieDetailViewModel {
    
    func getMovieDetails() {
        guard let id = self.selectedMovie?.id , id != 0 else {
            self.popToMovieList.onNext(())
            return
        }
        
        let parameter = [
            Params.apiKey.rawValue : Environment.MOVIEDB_APIKEY(),
        ] as [String : Any]
        
        dependencies.api.getMovieDetails(id: "\(id)", param: parameter)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        self._getMoviesDetailData.on(event)
                    case .failure(let error):
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
