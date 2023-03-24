//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Emad Habib on 10/20/20.
//  Copyright © 2020 MAC240. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SearchViewController: BaseViewController{
    
    @IBOutlet weak var tblMovies :UITableView!
    var viewModel :SearchViewModel!

    //MARK:- View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Memory Management Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Setup Methods
extension SearchViewController {
    
    private func setupUI() {
        self.configureNavigationWithAction(NSLocalizedString("Movie App", comment: ""), leftImage: nil, actionForLeft: nil, rightImage: nil, actionForRight: nil)
        self.tblMovies.tableFooterView = UIView()
        self.tblMovies.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        self.setupBinding(with: self.viewModel)
    }
    
    private func setupBinding(with viewModel: SearchViewModel){
        
        self.viewModel.movieTableData.asObservable()
            .bind(to: tblMovies.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)) { row, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
        
        self.tblMovies.rx.modelSelected(Movie.self).bind(to: viewModel.selectedMovie).disposed(by: disposeBag)
        
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }
                self.hideActivityIndicator()
                if isLoading {
                    self.showActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                self.showAlert(withMessage: title, withActions: .init(title: "OK", style: .default))
            }).disposed(by: disposeBag)
    }
}
