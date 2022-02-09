//
//  VKResponce.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 03.02.2022.
//

import Foundation

struct VKResponse<T:Decodable> {
    let response: T
}

extension VKResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}
