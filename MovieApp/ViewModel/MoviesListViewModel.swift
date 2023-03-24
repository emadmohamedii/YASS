////
////  MoviesListViewModel.swift
////  MovieApp
////
////  Created by Emad Habib on 11/12/20.
////  Copyright © 2018 Emad Habib. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import RxSwift
//import RxCocoa
//import CoreData
//
//final class FavMoviesListViewModel: BaseViewModel {
//    
//    // Dependencies
//    private let dependencies: Dependencies
//    var managedObjectContext: NSManagedObjectContext!
//    
//    /// Network request in progress
//    let isLoading: ActivityIndicator =  ActivityIndicator()
//    
//    //API Result
//    var getMoviesData: Observable<APIResult<GetMovieResponse>> {
//        return _getMoviesData.asObservable().observeOn(MainScheduler.instance)
//    }
//    private let _getMoviesData = ReplaySubject<APIResult<GetMovieResponse>>.create(bufferSize: 1)
//    
//    //Data
//    var movieTableData: Observable<[Movie]>
//    var movies: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
//    
//    //Paging Metadata
//    var nextPage: Int? = 1
//    var isFromCoredata: Bool = false
//
//    //Method
//    var callNextPage = PublishSubject<Void>()
//    let selectedMovie = PublishSubject<Movie?>()
//    
//    init(dependencies: Dependencies) {
//        self.dependencies = dependencies
//        self.movieTableData = movies.asObservable()
//        self.managedObjectContext = dependencies.managedObjectContext
//        super.init()
//        
//        self.callNextPage.asObservable().subscribe(onNext: { [weak self] in
//            guard let `self` = self else { return }
//            // Check internet availability, call next page API if internet available
//            if NetworkReachabilityManager()!.isReachable == true {
//                if self.nextPage != nil {
//                    self.getMovies(nextPage: self.nextPage!)
//                }
//            } else {
//                // Fetch movie data from local cache, as internet is not available
//                self.getMoviesFromCoreData()
//            }
//        }).disposed(by: disposeBag)
//        
//        getMoviesData
//            .subscribe(onNext: { [weak self] (result) in
//                guard let `self` = self else { return }
//                switch result {
//                case .success(let response):
//                    if response.results != nil {
//                        for movie in response.results! {
//                            _ = try? self.managedObjectContext.rx.update(MoviesCoredataModel.init(movie: movie))
//                        }
//                        if let results_ = response.results {
//                            self.movies.acceptAppending(results_)
//                        }
//                    }
//                    self.nextPage = response.nextPage
//                default:
//                    break
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//        
//}
//
////MARK:- Core Data
//extension FavMoviesListViewModel {
//    
//    func getMoviesFromCoreData() {
//        
//        isFromCoredata = true
//        managedObjectContext.rx.entities(MoviesCoredataModel.self, sortDescriptors: []).asObservable()
//            .subscribe(onNext: { [weak self] movieModels in
//                guard let `self` = self else {return}
//                
//                // Check local cache record count and binded array count same, no need to execute further code
//                if self.movies.value.count == movieModels.count {
//                    return
//                }
//                
//                var movies = [Movie]()
//                for movie in movieModels {
//                    let movieModel = Movie.init(model: movie)
//                    // Check movie object is contains in main array which bind to tableview, ignore that object
//                    if self.movies.value.contains(where: { $0.id == movieModel.id }) == false {
//                        movies.append(Movie.init(model: movie))
//                    }
//                }
//                
//                self.movies.accept(movies)
//                self.nextPage = (self.movies.value.count/20)+1
//            }).disposed(by: disposeBag)
//    }
//    
//}
//
//
