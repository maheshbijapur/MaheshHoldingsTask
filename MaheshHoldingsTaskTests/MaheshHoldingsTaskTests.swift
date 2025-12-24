//
//  MaheshHoldingsTaskTests.swift
//  MaheshHoldingsTaskTests
//
//  Created by Mahesh on 12/24/25.
//

import XCTest
@testable import MaheshHoldingsTask

final class MaheshHoldingsTaskTests: XCTestCase {

    private var viewModel: HoldingsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HoldingsViewModel()
        viewModel.setHoldings(mockHoldings)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testCurrentValueCalculation() {
        XCTAssertEqual(viewModel.currentValue, 19168.85, accuracy: 0.01)
    }

    func testTotalInvestmentCalculation() {
        XCTAssertEqual(viewModel.totalInvestment, 19748.5, accuracy: 0.01)
    }

    func testTotalPNLCalculation() {
        XCTAssertEqual(viewModel.totalPNL, -579.65, accuracy: 0.01)
    }

    func testTodaysPNLCalculation() {
        XCTAssertEqual(viewModel.todaysPNL, -48.85, accuracy: 0.01)
    }
    
    //MARK: Mock Data
    private let mockHoldings: [Holding] = [
        Holding(symbol: "ASHOKLEY", quantity: 3, ltp: 119.1, avgPrice: 115.0, close: 120.0),
        Holding(symbol: "HDFC", quantity: 7, ltp: 2497.2, avgPrice: 2600.0, close: 2490.0),
        Holding(symbol: "ICICIBANK", quantity: 1, ltp: 624.7, avgPrice: 600.0, close: 620.0),
        Holding(symbol: "IDEA", quantity: 71, ltp: 9.95, avgPrice: 8.5, close: 10.0)
    ]
}
