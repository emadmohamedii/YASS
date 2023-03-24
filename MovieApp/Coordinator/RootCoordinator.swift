//
//  RootCoordinator.swift
//  MovieApp
//
//  Created by Emad Habib on 24/03/2023.
//  Copyright © 2023 MAC240. All rights reserved.
//


import UIKit
import RxSwift

class RootCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let dependencies: Dependencies
    private let rootNavigationController:UINavigationController

    
    init(window: UIWindow,dependencies: Dependencies,navigationController:UINavigationController) {
        self.dependencies = dependencies
        self.window = window
        self.rootNavigationController = navigationController
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewModel = SearchViewModel.init(dependencies: self.dependencies)
        let viewController = UIStoryboard.main.searchViewController
        viewController.viewModel = viewModel
        
        viewModel.selectedMovie.asObservable().subscribe(onNext: {[weak self] movie in
            guard let `self` = self else {return}
            guard let _movie = movie else {return}
            self.pushToMovieDetails(selectedMovie: _movie)
        }).disposed(by: disposeBag)
        
        rootNavigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
    func pushToMovieDetails(selectedMovie: Movie) {
        let viewModel = MovieDetailViewModel.init(dependencies: self.dependencies, movie: selectedMovie)
        let viewController = UIStoryboard.main.movieDetailsViewController
        viewController.viewModel = viewModel
        
        viewModel.popToMovieList
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.rootNavigationController.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        rootNavigationController.pushViewController(viewController, animated: true)
    }
}
