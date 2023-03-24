//
//  BaseViewModel.swift
//  MovieApp
//
//  Created by Emad Habib on 24/03/2023.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    // Dispose Bag
    let disposeBag = DisposeBag()
    let alertDialog = PublishSubject<(String,String)>()
    
}
