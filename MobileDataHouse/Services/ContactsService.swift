//
//  ContactsService.swift
//  MobileDataHouse
//
//  Created by Ibragim Akaev on 15/08/2021.
//

import UIKit
import Contacts
import Combine

final class ContactsService {
    
    static let shared = ContactsService()
    private init() {}
    
    func accessGranted() -> Future<Bool, Error> {
        Future { promise in
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if let error = error {
                    return promise(.failure(error))
                }
                return promise(.success(granted))
            }
        }
    }
    
    func fetchContacts() -> AnyPublisher<[Contact], Never> {
        var contacts = [Contact]()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try CNContactStore().enumerateContacts(with: request, usingBlock: { contact, _ in
                contacts.append(Contact(fullName: "\(contact.givenName) \(contact.familyName)",
                                        number: contact.phoneNumbers.first?.value.stringValue ?? "There is no number"))
            })
        } catch let error {
            print("Failed to enumerate contact", error)
        }
        return Just(contacts)
            .eraseToAnyPublisher()
    }
}



