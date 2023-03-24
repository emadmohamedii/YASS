////
////  DiscoverCoordinator.swift
////  MovieApp
////
////  Created by Emad Habib on 05/12/2020.
////  Copyright © 2020 MAC240. All rights reserved.
////
//
//import UIKit
//import RxSwift
//import CoreData
//
//class DiscoverCoordinator: BaseCoordinator<Void>{
//    typealias Dependencies = HasWindow & HasAPI & HasCoreData
//
//    private let rootNavigationController:UINavigationController
//    private let dependencies: Dependencies
//
//    init(navigationController:UINavigationController, dependencies: Dependencies) {
//        self.rootNavigationController = navigationController
//        self.dependencies = dependencies
//    }
//
//    override func start() -> Observable<CoordinationResult> {
//        let viewModel = MoviesListViewModel.init(dependencies: self.dependencies)
//        let viewController = UIStoryboard.main.moviesListViewController
//        viewController.viewModel = viewModel
//        
//        viewModel.selectedMovie.subscribe(onNext: { [weak self] movie in
//            guard let `self` = self else { return }
//            guard let movie = movie else { return }
//            self.pushToMovieDetails(selectedMovie:movie)
//        }).disposed(by: disposeBag)
//        
//        rootNavigationController.pushViewController(viewController, animated: true)
//        return Observable.never()
//    }
//
//    func pushToMovieDetails(selectedMovie: Movie) {
//        let viewModel = MovieDetailViewModel.init(dependencies: self.dependencies, movie: selectedMovie)
//        let viewController = UIStoryboard.main.movieDetailsViewController
//        viewController.viewModel = viewModel
//        
//        viewModel.popToMovieList
//            .subscribe(onNext: { [weak self] in
//                guard let `self` = self else { return }
//                self.rootNavigationController.popViewController(animated: true)
//            }).disposed(by: disposeBag)
//        
//        rootNavigationController.pushViewController(viewController, animated: true)
//    }
//
//    deinit {
//        plog(DiscoverCoordinator.self)
//    }
//}
//
//
