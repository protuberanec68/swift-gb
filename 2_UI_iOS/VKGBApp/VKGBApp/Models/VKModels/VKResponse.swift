//
//  VKResponse.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 08.10.2021.
//

struct VKResponse<T:Decodable> {
    let response: T
}

extension VKResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

