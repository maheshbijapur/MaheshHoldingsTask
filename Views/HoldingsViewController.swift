
//
//  HoldingsViewController.swift.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import UIKit

final class HoldingsViewController: UIViewController {

    private let viewModel = HoldingsViewModel()
    private let tableView = UITableView()
    private let summaryView = PortfolioSummaryView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "Portfolio"

        view.addSubview(tableView)
        view.addSubview(summaryView)
        
        setupTableView()
        setupSummaryView()
        fetchData()
        setupLoader()
        activityIndicator.startAnimating()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HoldingCell.self, forCellReuseIdentifier: HoldingCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: summaryView.topAnchor) // ✅ now legal
        ])
    }

    
    private func setupSummaryView() {
        summaryView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    private func fetchData() {
        viewModel.fetchHoldings { [weak self] in
            guard let self else { return }

            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()

            self.summaryView.configure(
                currentValue: self.viewModel.currentValue,
                totalInvestment: self.viewModel.totalInvestment,
                todaysPNL: self.viewModel.todaysPNL,
                totalPNL: self.viewModel.totalPNL
            )
        }
    }

    private func setupLoader() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

// MARK: - UITableViewDataSource

extension HoldingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.holdings.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HoldingCell.reuseIdentifier,
            for: indexPath
        ) as? HoldingCell else {
            return UITableViewCell()
        }

        let holding = viewModel.holdings[indexPath.row]
        cell.configure(with: holding)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HoldingsViewController: UITableViewDelegate { }
