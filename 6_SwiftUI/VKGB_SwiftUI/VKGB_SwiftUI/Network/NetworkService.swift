//
//  NetworkService.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 03.02.2022.
//

import Foundation

final class NetworkService {
    
    private let session = URLSession.shared
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        
        return constructor
    }()
    
    final func fetchUsers(
        from userID: String,
        completion: (@escaping (Result<[User],FetchDataError>) -> Void )) {
            constructRequestPath(requestType: "friends.get")
            constructUsersRequestQueryItems(for: userID)
            sendRequest(endpoint: Users.init(items: [])) { result in
                switch result {
                case .success(let users):
                    completion(.success(users.items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
//    final func fetchGroups(
//        from userID: String,
//        completion: (@escaping (Result<[User],FetchDataError>) -> Void )) {
//            constructRequestPath(requestType: "groups.get")
//            constructGroupsRequestQueryItems(for: userID)
//            sendRequest(endpoint: Groups.init(items: [])) { result in
//                switch result {
//                case .success(let groups):
//                    completion(.success(groups.items))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
    
//    final func fetchPhotos(
//        from userID: String,
//        completion: (@escaping (Result<[Photo],FetchDataError>) -> Void )) {
//            constructRequestPath(requestType: "photos.getAll")
//            constructPhotosRequestQueryItems(for: userID)
//            sendRequest(endpoint: Photos.init(items: [])) { result in
//                switch result {
//                case .success(let photos):
//                    completion(.success(photos.items))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
    
//    final func fetchSeachedGroups(
//        with queryString: String,
//        completion: (@escaping (Result<[User],FetchDataError>) -> Void )) {
//            constructRequestPath(requestType: "groups.search")
//            constructSeachedGroupsRequestQueryItems(queryString: queryString)
//            sendRequest(endpoint: Groups.init(items: [])) { result in
//                switch result {
//                case .success(let groups):
//                    completion(.success(groups.items))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
    
//    final func fetchNews(
//        nextFrom: String,
//        completion: (@escaping (Result<[User],FetchDataError>) -> Void )) {
//            constructRequestPath(requestType: "newsfeed.getRecommended")
//            constructNewsRequestQueryItems(nextFrom: nextFrom)
//            sendRequest(endpoint: News.init(items: [])) { result in
//                switch result {
//                case .success(let news):
//                    completion(.success(news.items))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
    
    
    private func sendRequest<T: Decodable>(
        endpoint: T,
        completion: (@escaping (Result<T,FetchDataError>) -> Void )) {
            guard let url = urlConstructor.url
            else {
                completion(.failure(.failUrlConstruct))
                return
            }
            var request = URLRequest(url: url)
            request.timeoutInterval = 30.0
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
    
    private func constructRequestPath(requestType: String){
        urlConstructor.path = "/method/" + requestType
    }
    
    private func constructGeneralRequestQueryItems(){
        urlConstructor.queryItems = [
            URLQueryItem(
                name: "access_token",
                value: Singleton.instance.token),
            URLQueryItem(
                name: "v",
                value: "5.131"),
        ]
    }
    
    private func constructUsersRequestQueryItems(for userID: String){
        
        constructGeneralRequestQueryItems()
        
        urlConstructor.queryItems?.append(
            URLQueryItem(
                name: "user_id",
                value: userID)
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
                value: "photo_100")
        )
    }
    
//    private func constructGroupsRequestQueryItems(for userID: String){
//
//        constructGeneralRequestQueryItems()
//
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "user_id",
//                value: userID)
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "extended",
//                value: "1")
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "count",
//                value: "5")
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "fields",
//                value: "name,description,photo_100")
//        )
//    }
    
    
//    private func constructPhotosRequestQueryItems(for userID: String){
//
//        constructGeneralRequestQueryItems()
//
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "owner_id",
//                value: userID)
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "extended",
//                value: "1")
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "count",
//                value: "10")
//        )
//    }
    
//    private func constructSeachedGroupsRequestQueryItems(queryString: String){
//
//        constructGeneralRequestQueryItems()
//
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "q",
//                value: queryString)
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "count",
//                value: "10")
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "fields",
//                value: "name,description,photo_100")
//        )
//    }

//    private func constructNewsRequestQueryItems(nextFrom: String){
//
//        constructGeneralRequestQueryItems()
//
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "count",
//                value: "10")
//        )
//        urlConstructor.queryItems?.append(
//            URLQueryItem(
//                name: "start_from",
//                value: nextFrom)
//        )
//    }
    
}
