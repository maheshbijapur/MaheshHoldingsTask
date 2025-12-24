//
//  HoldingsViewModel.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import Foundation

final class HoldingsViewModel {

    // MARK: - State
    private(set) var holdings: [Holding] = []

    // MARK: - Data Fetch
    func fetchHoldings(completion: @escaping () -> Void) {
        HoldingsService.fetchHoldings { [weak self] result in
            switch result {
            case .success(let data):
                self?.holdings = data
            case .failure:
                self?.holdings = []
            }
            completion()
        }
    }

    // MARK: - Portfolio Calculations

    /// Sum of (LTP * Quantity)
    var currentValue: Double {
        holdings.reduce(0) {
            $0 + ($1.ltp * Double($1.quantity))
        }
    }

    /// Sum of (Average Price * Quantity)
    var totalInvestment: Double {
        holdings.reduce(0) {
            $0 + ($1.avgPrice * Double($1.quantity))
        }
    }

    /// Current Value - Total Investment
    var totalPNL: Double {
        currentValue - totalInvestment
    }

    /// Sum of ((Close - LTP) * Quantity)
    var todaysPNL: Double {
        holdings.reduce(0) {
            $0 + (($1.close - $1.ltp) * Double($1.quantity))
        }
    }
}
