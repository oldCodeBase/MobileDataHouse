//
//  UITableView + Extensions.swift
//  MobileDataHouse
//
//  Created by Ibragim Akaev on 15/08/2021.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
