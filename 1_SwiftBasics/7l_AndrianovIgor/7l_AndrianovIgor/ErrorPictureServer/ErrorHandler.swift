//
//  Error.swift
//  7l_AndrianovIgor
//
//  Created by Игорь Андрианов on 09.08.2021.
//

import Foundation

class DownloadErrorHandler {
    func downloadPicture(server: PictureServer) {
        do {
            let result = try server.downloadPicture()
            print(result)
        }
        catch ServerDownloadError.pictureStorageEmpty (let message),
              ServerDownloadError.tooMuchRequestsPerSession (let message) {
            print("Ошибка - \(message)")
        }
        catch {
            print("Неопознанная ошибка")
        }
    }
}

class UploadErrorHandler {
    func uploadPicture(server: PictureServer) {
        do {
            let picture = "Квадрат"
            let _ = try server.uploadPicture(picture: picture)
            print("Картина \(picture) загружена")
        }
        catch ServerUploadError.pictureStorageFull (let message) {
            print("Ошибка - \(message)")
        }
        catch {
            print("Неопознанная ошибка")
        }
    }
}
