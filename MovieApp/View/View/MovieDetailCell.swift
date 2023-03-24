//
//  MovieDetailCell.swift
//  MovieApp
//
//  Created by Emad Habib on 24/03/2023.
//  Copyright © 2023 MAC240. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Movie Details Cell
class MovieDetailCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    func configure(tableData: MovieDetailsViewController.TableData) {
        self.lblTitle.text = tableData.title ?? ""
        self.lblDescription.text = tableData.description ?? ""
    }
}
