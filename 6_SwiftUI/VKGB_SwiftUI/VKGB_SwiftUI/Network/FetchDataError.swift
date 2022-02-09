//
//  VKError.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 03.02.2022.
//

import Foundation

enum FetchDataError: Error {
    case failUrlConstruct
    case failResponseData
    case failJSONDecode
}
