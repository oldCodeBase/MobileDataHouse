//
//  ContactsViewController.swift
//  MobileDataHouse
//
//  Created by Ibragim Akaev on 15/08/2021.
//

import UIKit
import Combine

final class ContactsViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel = ContactsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        binding()
    }
    
    private func setupNavBar() {
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactCell.self)
    }
    
    private func binding() {
        viewModel.contacts
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                tableView.reloadData()
            }.store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ContactCell.self, indexPath: indexPath)
        cell.configure(with: viewModel.contact(at: indexPath))
        return cell
    }
}

// MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.makeCall(indexPath)
    }
}
