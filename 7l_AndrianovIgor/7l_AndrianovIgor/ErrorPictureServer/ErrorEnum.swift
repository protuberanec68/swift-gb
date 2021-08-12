//
//  ErrorEnum.swift
//  7l_AndrianovIgor
//
//  Created by Игорь Андрианов on 09.08.2021.
//

import Foundation

enum PowerError: String, Error {
    case powerOff = "электричества нет"
}

enum ServerUploadError: Error {
    case pictureStorageFull (message: String)
}

enum ServerDownloadError: Error {
    case pictureStorageEmpty (message: String)
    case tooMuchRequestsPerSession (message: String)
}

