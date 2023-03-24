//
//  UIStoryboard+Controllers.swift
//  MovieApp
//
//  Created by Emad Habib on 24/03/2023.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}


extension UIStoryboard {
            
    var searchViewController: SearchViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as? SearchViewController else {
            fatalError(String(describing: SearchViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    
    var movieDetailsViewController: MovieDetailsViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as? MovieDetailsViewController else {
            fatalError(String(describing: MovieDetailsViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }

}
