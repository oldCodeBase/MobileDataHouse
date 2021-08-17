//
//  String + Extension.swift
//  MobileDataHouse
//
//  Created by Ibragim Akaev on 16/08/2021.
//

import Foundation

extension String {
    var digitsOnly: String { filter { ("0"..."9").contains($0) } }
}
