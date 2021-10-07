//
//  Network.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 02.10.2021.
//

import Foundation

final class Network {
    
    private let session = URLSession.shared
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        
        return constructor
    }()
    
    func sendRequest(requestType: String) {
        urlConstructor.path = "/method/" + requestType
        urlConstructor.queryItems = [
            URLQueryItem(
                name: "access_token",
                value: Session.instance.token),
            URLQueryItem(
                name: "v",
                value: "5.131"),
        ]
        switch requestType {
        case "groups.get":
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "user_id",
                    value: String(Session.instance.userID))
            )
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "extended",
                    value: "1")
            )
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "count",
                    value: "5")
            )
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "fields",
                    value: "name")
            )
        case "friends.get":
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "user_id",
                    value: String(Session.instance.userID))
            )
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "order",
                    value: "name")
            )
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "name_case",
                    value: "ins")
            )
            urlConstructor.queryItems?.append(
                URLQueryItem(
                    name: "fields",
                    value: "nickname")
            )
        case "groups.search":
            urlConstructor.queryItems?.append(                URLQueryItem(
                name: "q",
                value: "спорт")
            )
            urlConstructor.queryItems?.append(                       URLQueryItem(
                name: "count",
                value: "2")
            )
        case "photos.getAll":
            urlConstructor.queryItems?.append(                URLQueryItem(
                name: "owner_id",
                value: String(Session.instance.userID))
            )
            urlConstructor.queryItems?.append(                URLQueryItem(
                name: "extended",
                value: "1")
            )
            urlConstructor.queryItems?.append(                       URLQueryItem(
                name: "count",
                value: "3")
            )
        default:
            return
        }

        
        guard let url = urlConstructor.url else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.setValue(
            "",
            forHTTPHeaderField: "Token")
        
        session.dataTask(with: request) { responseData, urlResponse, error in
            guard
                error == nil,
                let responseData = responseData
            else { return }
            let json = try? JSONSerialization.jsonObject(
                with: responseData,
                options: .fragmentsAllowed)
            print(json)
        }
        .resume()
        
    }
}
