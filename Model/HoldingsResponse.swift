//
//  HoldingsResponse.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import Foundation

struct HoldingsResponse: Decodable {
    let data: HoldingsData
}

struct HoldingsData: Decodable {
    let userHolding: [Holding]
}
