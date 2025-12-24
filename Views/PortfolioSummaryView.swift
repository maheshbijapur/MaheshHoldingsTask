//
//  PortfolioSummaryView.swift
//  MaheshHoldingsTask
//
//  Created by Mahesh on 12/24/25.
//

import UIKit

import UIKit

final class PortfolioSummaryView: UIView {

    // MARK: - UI Elements

    private let expandableStack = UIStackView()
    private let footerRow = UIStackView()

    private let currentValueLabel = UILabel()
    private let totalInvestmentLabel = UILabel()
    private let todaysPNLLabel = UILabel()
    private let totalPNLLabel = UILabel()
    private let arrowLabel = UILabel()

    // MARK: - State

    private var isExpanded = false

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.separator.cgColor

        setupExpandableStack()
        setupFooterRow()

        let containerStack = UIStackView(arrangedSubviews: [
            expandableStack,
            footerRow
        ])
        containerStack.axis = .vertical
        containerStack.spacing = 8
        containerStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerStack)

        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

        setExpanded(false)
    }

    // MARK: - Expandable Content

    private func setupExpandableStack() {
        expandableStack.axis = .vertical
        expandableStack.spacing = 8

        expandableStack.addArrangedSubview(
            makeRow(title: "Current value", valueLabel: currentValueLabel)
        )
        expandableStack.addArrangedSubview(
            makeRow(title: "Total investment", valueLabel: totalInvestmentLabel)
        )
        expandableStack.addArrangedSubview(
            makeRow(title: "Today's Profit & Loss", valueLabel: todaysPNLLabel)
        )
    }

    // MARK: - Footer Row (Always Visible)

    private func setupFooterRow() {
        let titleLabel = UILabel()
        titleLabel.text = "Profit & Loss*"
        titleLabel.font = .systemFont(ofSize: 14)

        totalPNLLabel.font = .boldSystemFont(ofSize: 14)
        totalPNLLabel.textAlignment = .right

        arrowLabel.font = .systemFont(ofSize: 14)
        arrowLabel.text = "⌄"

        footerRow.axis = .horizontal
        footerRow.alignment = .center
        footerRow.spacing = 8

        footerRow.addArrangedSubview(titleLabel)
        footerRow.addArrangedSubview(UIView()) // spacer
        footerRow.addArrangedSubview(totalPNLLabel)
        footerRow.addArrangedSubview(arrowLabel)

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(toggleExpanded)
        )
        footerRow.addGestureRecognizer(tapGesture)
        footerRow.isUserInteractionEnabled = true
    }

    // MARK: - Row Helper

    private func makeRow(title: String, valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel

        valueLabel.font = .boldSystemFont(ofSize: 14)
        valueLabel.textAlignment = .right

        let row = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        row.axis = .horizontal
        row.spacing = 8

        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)

        return row
    }

    // MARK: - Toggle Logic

    @objc private func toggleExpanded() {
        setExpanded(!isExpanded)

        UIView.animate(withDuration: 0.25) {
            self.superview?.layoutIfNeeded()
        }
    }

    private func setExpanded(_ expanded: Bool) {
        isExpanded = expanded
        expandableStack.isHidden = !expanded
        arrowLabel.text = expanded ? "⌃" : "⌄"
    }

    // MARK: - Configuration

    func configure(
        currentValue: Double,
        totalInvestment: Double,
        todaysPNL: Double,
        totalPNL: Double
    ) {
        currentValueLabel.text = CurrencyFormatter.format(currentValue)
        totalInvestmentLabel.text = CurrencyFormatter.format(totalInvestment)
        todaysPNLLabel.text = CurrencyFormatter.format(todaysPNL)

        let percentage = (totalPNL / totalInvestment) * 100
        totalPNLLabel.text = String(
            format: "%@ (%.2f%%)",
            CurrencyFormatter.format(totalPNL),
            percentage
        )

        todaysPNLLabel.textColor = todaysPNL >= 0 ? .systemGreen : .systemRed
        totalPNLLabel.textColor = totalPNL >= 0 ? .systemGreen : .systemRed
    }
}

