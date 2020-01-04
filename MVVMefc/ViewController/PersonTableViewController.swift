//
//  PersonTableViewController.swift
//  MVVMefc
//
//  Created by eduardo fulgencio on 04/01/2020.
//  Copyright © 2020 Eduardo Fulgencio Comendeiro. All rights reserved.
//

import UIKit
import PKHUD


public class PersonTableViewController: UITableViewController {

    let viewModel: PersonsTableViewViewModel = PersonsTableViewViewModel()

    public override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getPersons()
    }

    func bindViewModel() {
        viewModel.personCells.bindAndFire() { [weak self] _ in
            self?.tableView?.reloadData()
        }

        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }


        viewModel.showLoadingHud.bind() { [weak self] visible in
            if let `self` = self {
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
            }
        }
    }

}

// MARK: - UITableViewDelegate
extension PersonTableViewController {

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.personCells.value.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch viewModel.personCells.value[indexPath.row] {
        case .normal(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as? PersonTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel
            return cell
        case .error(let message):
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = message
            return cell
        case .empty:
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = "No data available"
            return cell
        }
    }

    public override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           //  viewModel.deleteFriend(at: indexPath.row)
        }
    }
}

extension PersonTableViewController: SingleButtonDialogPresenter { }

