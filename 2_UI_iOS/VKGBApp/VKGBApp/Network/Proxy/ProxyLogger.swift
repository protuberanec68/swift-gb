//
//  ProxyLogger.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 03.01.2022.
//

import Foundation

class ProxyNetworkLogger: NetworkProtocol{
    var networkService: Network
    
    func sendRequest<T: Decodable>(
        endpoint: T,
        requestType: String,
        userID: Int = Singleton.instance.userID,
        queryString: String = "",
        nextListVKNewsID nextFrom: String = "\"\"",
        completion: @escaping ((Result<T, VKError>) -> Void)) {
        networkService.sendRequest(endpoint: endpoint, requestType: requestType, userID: userID, queryString: queryString, nextListVKNewsID: nextFrom, completion: completion)
        print("Request-info is logged")
    }
    
    init(networkService: Network){
        self.networkService = networkService
    }
}
