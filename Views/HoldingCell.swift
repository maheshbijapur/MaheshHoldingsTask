//
//  HoldingCell.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import UIKit

final class HoldingCell: UITableViewCell {

    static let reuseIdentifier = "HoldingCell"

    private let symbolLabel = UILabel()
    private let quantityLabel = UILabel()

    private let ltpLabel = UILabel()
    private let pnlLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        symbolLabel.font = .boldSystemFont(ofSize: 16)

        quantityLabel.font = .systemFont(ofSize: 12)
        quantityLabel.textColor = .secondaryLabel

        ltpLabel.font = .systemFont(ofSize: 14)
        ltpLabel.textAlignment = .right

        pnlLabel.font = .systemFont(ofSize: 14)
        pnlLabel.textAlignment = .right

        let leftStack = UIStackView(arrangedSubviews: [symbolLabel, quantityLabel])
        leftStack.axis = .vertical
        leftStack.spacing = 4

        let rightStack = UIStackView(arrangedSubviews: [ltpLabel, pnlLabel])
        rightStack.axis = .vertical
        rightStack.spacing = 4
        rightStack.alignment = .trailing
        rightStack.widthAnchor.constraint(equalToConstant: 120).isActive = true

        let mainStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 8
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with holding: Holding) {
        symbolLabel.text = holding.symbol
        quantityLabel.text = "NET QTY: \(holding.quantity)"

        ltpLabel.text = "LTP: \(CurrencyFormatter.format(holding.ltp))"

        let pnl = (holding.ltp - holding.avgPrice) * Double(holding.quantity)
        pnlLabel.text = "P&L: \(CurrencyFormatter.format(pnl))"
        pnlLabel.textColor = pnl >= 0 ? .systemGreen : .systemRed
    }
}

