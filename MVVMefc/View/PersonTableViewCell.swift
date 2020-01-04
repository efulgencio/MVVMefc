//
//  PersonTableViewCell.swift
//  MVVMefc
//
//  Created by eduardo fulgencio on 04/01/2020.
//  Copyright © 2020 Eduardo Fulgencio Comendeiro. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    
    var viewModel: PersonCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    private func bindViewModel() {
        labelName?.text = viewModel?.nameModif
        labelAge?.text = viewModel?.ageText
    }
    
}
