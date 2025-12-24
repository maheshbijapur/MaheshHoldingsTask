//
//  HoldingsService.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import Foundation

enum HoldingsService {

    static func fetchHoldings(
        completion: @escaping (Result<[Holding], Error>) -> Void
    ) {
        let urlString = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(HoldingsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.data.userHolding))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

        }.resume()
    }
}
