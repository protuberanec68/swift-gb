//
//  Network.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 02.10.2021.
//

import UIKit

final class Network {
    
    private let session = URLSession.shared
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        
        return constructor
    }()
    
    func sendRequest<T: Decodable>(
        endpoint: T,
        requestType: String,
        userID: Int = Singleton.instance.userID,
        queryString: String = "",
        nextListVKNewsID nextFrom: String = "\"\"",
        completion: (@escaping (Result<T,VKError>) -> Void )) {
            constructRequest(
                requestType: requestType,
                userID: userID,
                queryString: queryString,
                nextFrom: nextFrom)
            guard let url = urlConstructor.url
            else {
                completion(.failure(.failUrlConstruct))
                return
            }
            var request = URLRequest(url: url)
            request.timeoutInterval = 10.0
            request.setValue(
                "",
                forHTTPHeaderField: "Token")
            session.dataTask(with: request) { responseData, urlResponse, error in
                guard
                    error == nil,
                    let responseData = responseData
                else {
                    completion(.failure(.failResponseData))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(
                        VKResponse<T>.self,
                        from: responseData)
                    DispatchQueue.main.async {
                        completion(.success(response.response))
                    }
                } catch {
                    print(error)
                    completion(.failure(.failJSONDecode))
                    return
                }
            }
            .resume()
        }
    
    
    private func constructRequest(
        requestType: String,
        userID: Int,
        queryString: String,
        nextFrom: String) {
            urlConstructor.path = "/method/" + requestType
            urlConstructor.queryItems = [
                URLQueryItem(
                    name: "access_token",
                    value: Singleton.instance.token),
                URLQueryItem(
                    name: "v",
                    value: "5.131"),
            ]
            switch requestType {
            case "groups.get":
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "user_id",
                        value: String(userID))
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
                        value: "name,description,photo_100")
                )
            case "friends.get":
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "user_id",
                        value: String(userID))
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
                        value: "nickname,photo_100")
                )
            case "groups.search":
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "q",
                        value: queryString)
                )
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "count",
                        value: "10")
                )
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "fields",
                        value: "name,description,photo_100")
                )
                
            case "photos.getAll":
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "owner_id",
                        value: String(userID))
                )
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "extended",
                        value: "1")
                )
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "count",
                        value: "10")
                )
            case "newsfeed.getRecommended":
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "count",
                        value: "10")
                )
                urlConstructor.queryItems?.append(
                    URLQueryItem(
                        name: "start_from",
                        value: nextFrom)
                )
            default:
                return
            }
        }
    
}
