//
//  Int + Ext.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import Foundation

extension Double {
    func date() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
