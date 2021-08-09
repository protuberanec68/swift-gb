//
//  main.swift
//  7l_AndrianovIgor
//
//  Created by Игорь Андрианов on 03.08.2021.
//

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import Foundation

func checkResult(_ result: Result) {
    if let error = result.1 {
        print ("Ошибка - \(error.rawValue)")
        return
    }
    print("Всего включений - \(result.0)")
}

var castle = Castle()

var resultStore: [Result] = []
    
resultStore.append(castle.changeLightState())
resultStore.append(castle.changeLightState())
castle.changePowerState()
resultStore.append(castle.changeLightState())

for result in resultStore {
    checkResult(result)
}

print("________________________________")

let downloadHandler = DownloadErrorHandler()
let uploadHandler = UploadErrorHandler()
var server = PictureServer()

//MARK: ВОПРОС - можно ли как то конструкции do-catch ниже обернуть в функцию, чтобы такого кошмара в коде не было?

//пытаемся получить картинку с пустого хранилища
downloadHandler.downloadPicture(server: server)

//Загружаем картинку в хранилище
uploadHandler.uploadPicture(server: server)

//Изымаем картинку из хранилища
downloadHandler.downloadPicture(server: server)

//Загружаем картинку в хранилище
uploadHandler.uploadPicture(server: server)

//Пытаемся изъять картинку из хранилища
downloadHandler.downloadPicture(server: server)
