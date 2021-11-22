//
//  FetchJSONvkFriends.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 21.11.2021.
//

import Foundation
import Alamofire

final class FetchJSONvkGroups: AsyncOperation {
    
    var data: Data? = nil
    
    private func fetchFriends(complition: @escaping (AFDataResponse<Any>) -> Void ) {
        let host = "https://api.vk.com"
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "user_id": Singleton.instance.userID,
            "order": "name",
            "name_case": "ins",
            "fields": "nickname,photo_100",
            "access_token": Singleton.instance.token,
            "v": "5.131",
        ]

        AF.request(
            host + path,
            method: .get,
            parameters: parameters)
            .responseJSON() { result in
                complition(result)
            }
    }
    
    override func main() {
        fetchFriends() { result in
            if result.error == nil {
                self.data = result.data
            }
            self.state = .finished
        }
    }
}
