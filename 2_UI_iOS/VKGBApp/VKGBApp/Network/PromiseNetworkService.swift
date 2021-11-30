//
//  PromiseNetworkService.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 28.11.2021.
//

import UIKit
import PromiseKit

final class PromiseNetworkService {
    
    enum PromiseError: String, Error{
        case urlConstructFail = "Fail to Construct URL"
        case dataGetFail = "Fail to get data"
        case dataParsingFail = "Fail to parsing data"
        
    }
    
    private let session = URLSession.shared
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        
        return constructor
    }()
    
    func fetchGroupsToRealm() {
        fetchGroupsData()
            .then(on: .global()) { data in
                self.parsingGroups(responseData: data)
            }.map(on: .global()) { groups in
                self.saveGroupsToRealm(groups: groups)
            }.catch { error in
                print(error)
            }
    }
    
    private func fetchGroupsData() -> Promise<Data> {
        return Promise { result in
            constructGroupsRequest()
            guard let url = urlConstructor.url
            else {
                return result.reject(PromiseError.urlConstructFail)
            }
            var request = URLRequest(url: url)
            request.timeoutInterval = 10.0
            request.setValue(
                "",
                forHTTPHeaderField: "Token")
            session.dataTask(with: request) { responseData, urlResponse, error in
                guard
                    error == nil,
                    let response = responseData
                else { return result.reject(PromiseError.dataGetFail) }
                return result.fulfill(response)
            }
            .resume()
        }
    }
    
    private func parsingGroups(responseData: Data) -> Promise<[VKGroup]> {
        return Promise { result in
            do {
            let response = try JSONDecoder().decode(
                VKResponse<VKGroups>.self,
                from: responseData).response.items
                return result.fulfill(response)
            }
            catch { return result.reject(PromiseError.dataParsingFail) }
        }
    }
    
    
    private func saveGroupsToRealm(groups: [VKGroup]) {
        let realmGroups = groups.map { RealmGroup($0) }
        DispatchQueue.main.async {
            do {
                let myGroupsID = groups.map {$0.id}
                let notMyGroupsID = try RealmService.load(typeOf: RealmGroup.self).filter(NSPredicate(format: "NOT (id IN %@)", myGroupsID))
                try RealmService.delete(object: notMyGroupsID)
                try RealmService.save(items: realmGroups)
            } catch {
                print(error)
            }
        }
    }
    
    private func constructGroupsRequest() {
            urlConstructor.path = "/method/" + "groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(
                name: "access_token",
                value: Singleton.instance.token),
            URLQueryItem(
                name: "v",
                value: "5.131"),
            URLQueryItem(
                name: "user_id",
                value: String(Singleton.instance.userID)),
            URLQueryItem(
                name: "extended",
                value: "1"),
            URLQueryItem(
                name: "count",
                value: "5"),
            URLQueryItem(
                name: "fields",
                value: "name,description,photo_100"),
        ]
    }
}
