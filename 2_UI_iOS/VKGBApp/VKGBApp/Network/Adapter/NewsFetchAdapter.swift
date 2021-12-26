//
//  NewsFetchAdapter.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 26.12.2021.
//

import Foundation

final class NewsFetchAdapter{
    
    private let networkRequester = Network()
    private var news: [VKNew] = []
    private var nextListVKNewsID = ""
    
    func fetchNews(nextListVKNewsID: String = "\"\"", complition: @escaping ([VKNew],String) -> Void) {
        networkRequester.sendRequest(
            endpoint: VKNews.init(),
            requestType: "newsfeed.getRecommended",
            nextListVKNewsID: nextListVKNewsID) {
                [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let result):
                    DispatchQueue.global(qos: .userInteractive).async {
                        guard let news = result?.news(),
                              let nextListVKNewsID = result?.nextFrom
                        else {return}
                        DispatchQueue.main.async {
                            if news.last?.date != self.news.last?.date {
                                self.news = news
                            } else {
                                self.news = []
                            }
                            self.nextListVKNewsID = nextListVKNewsID
                            complition(self.news, self.nextListVKNewsID)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}
