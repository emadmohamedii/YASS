//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Emad Habib on 11/12/20.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {
    
    private let navigationController:UINavigationController
    private let window: UIWindow
    let dependencies: AppDependency
    
    init(window:UIWindow, navigationController:UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = AppDependency(window: self.window)
    }
    
    override func start() -> Observable<Void> {
        // Show Movie list screen
        return showTabBar()
    }
    
    private func showTabBar() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(window: window, dependencies: dependencies, navigationController: self.navigationController)
        return coordinate(to: rootCoordinator)
    }
    
    deinit {
        plog(AppCoordinator.self)
    }
    
}



