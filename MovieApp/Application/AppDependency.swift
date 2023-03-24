//
//  AppDependency.swift
//  MovieApp
//
//  Created by Emad Habib on 24/03/2023.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol HasWindow {
    var window: UIWindow { get }
}

protocol HasAPI {
    var api: API { get }
}

class AppDependency: HasWindow, HasAPI {
    
    let window: UIWindow
    let api: API
    
    init(window: UIWindow) {
        self.window = window
        self.api = API.shared
    }
}
