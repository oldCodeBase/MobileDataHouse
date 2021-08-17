//
//  ContactCell.swift
//  MobileDataHouse
//
//  Created by Ibragim Akaev on 15/08/2021.
//

import UIKit

final class ContactCell: UITableViewCell {
    
    private let fullNameLabel = UILabel()
    private let numberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        fullNameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        numberLabel.font = .systemFont(ofSize: 18, weight: .light)
    }
    
    private func setupLayout() {
        [fullNameLabel, numberLabel].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            numberLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 6),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
    
    func configure(with viewModel: Contact) {
        fullNameLabel.text = viewModel.fullName
        numberLabel.text = viewModel.number
    }
}
