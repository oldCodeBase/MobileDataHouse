//
//  ContactsViewModel.swift
//  MobileDataHouse
//
//  Created by Ibragim Akaev on 15/08/2021.
//

import UIKit
import Combine

final class ContactsViewModel {
    
    let title = "Contacts"
    var contacts = CurrentValueSubject<[Contact], Never>([])
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        ContactsService.shared.accessGranted()
            .sink { _ in }
                receiveValue: { [unowned self] _ in
                    self.fetchContacts()
                }.store(in: &cancellables)
    }
    
    func fetchContacts() {
        ContactsService.shared.fetchContacts()
            .sink { [unowned self] contacts in
                self.contacts.send(contacts)
            }.store(in: &cancellables)
    }
    
    func contact(at indexPath: IndexPath) -> Contact {
        contacts.value[indexPath.row]
    }
    
    func makeCall(_ indexPath: IndexPath) {
        let number = contacts.value[indexPath.row].number.digitsOnly
        if !number.isEmpty {
            guard let url = URL(string: "tel://\(number)") else { return }
            UIApplication.shared.open(url)
        }
    }
}
