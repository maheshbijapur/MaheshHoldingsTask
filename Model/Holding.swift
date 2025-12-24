//
//  Holding.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

struct Holding: Decodable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
}

