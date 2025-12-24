
//
//  HoldingsViewController.swift.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import UIKit

final class HoldingsViewController: UIViewController {

    private let viewModel = HoldingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Portfolio"

        viewModel.fetchHoldings { [weak self] in
            print("Holdings count:", self?.viewModel.holdings.count ?? 0)
            print("Current Value:", self?.viewModel.currentValue ?? 0)
        }
    }
}


