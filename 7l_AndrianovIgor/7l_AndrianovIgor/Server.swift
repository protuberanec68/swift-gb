//
//  server.swift
//  7l_AndrianovIgor
//
//  Created by Игорь Андрианов on 04.08.2021.
//

//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import Foundation

typealias Picture = String

class PictureServer {
    private var pictureStorage = Queue(storageLimit: 5)
    private var requestCount = 0
    private let requestsCountLimit = 2
    
    func downloadPicture() throws -> Picture {
        self.requestCount += 1
        guard requestCount <= requestsCountLimit else {
            throw ServerDownloadError.tooMuchRequestsPerSession (message: "слишком много запросов за сессию")
        }
        
        guard let picture = self.pictureStorage.pop() else {
            throw ServerDownloadError.pictureStorageEmpty (message: "картин нет")
        }
        
        return picture
    }
    
    func uploadPicture(picture: Picture) throws {
        guard pictureStorage.push(picture) else {
            throw ServerUploadError.pictureStorageFull (message: "хранилище картин заполнено")
        }
    }
}

struct Queue {
    var queue: [String] = []
    let storageLimit: Int
    
    mutating func push(_ element: String) -> Bool {
        guard self.queue.count < storageLimit else { return false }
        self.queue.append(element)
        return true
    }
    
    mutating func pop() -> String? {
        guard self.queue.count > 0 else { return nil }
        return self.queue.removeFirst()
    }
    
    init(storageLimit: Int) {
        self.storageLimit = storageLimit
    }
}



