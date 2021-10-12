//
//  VKError.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 09.10.2021.
//

enum VKError: Error {
    case failUrlConstruct
    case failResponseData
    case failJSONDecode
}


func foo() {
    let x = 0
    if x == 0 {
        print("123")
    } else {
        print("error")
    }
}

func bar(x: String) {
    guard let y = Int(x) else {
        print ("error")
        return
    }
    print(y)
    
    let z = Int(x)
}
