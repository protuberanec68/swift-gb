//
//  car.swift
//  5l_AndrianovIgor
//
//  Created by Игорь Андрианов on 27.07.2021.
//

import Foundation

protocol Car: AnyObject {
    var model: String { get }
    var type: TypeCar { get }
    var engineState: EngineState { get set }
    var windowsState: WindowsState { get set }
    
    func changeEngineState(to :EngineState)
    func changeWindowsState(to :WindowsState)
}

extension Car {
    
    func changeEngineState(to :EngineState) {
        self.engineState = to
    }
    func changeWindowsState(to :WindowsState) {
        self.windowsState = to
    }
}

enum EngineState: String {
    case on = "включен", off = "выключен"
}

enum WindowsState: String {
    case open = "открыты", close = "закрыты"
}

enum TypeCar: String {
    case trunk = "грузовой", sport = "спортивный"
}

class TrunkCar: Car, CustomStringConvertible {
    var description: String {
        return ("Это \(model) - \(type.rawValue) автомобиль с объемом цистерны \(trunkVolume) литров.\n Сейчас двигатель \(engineState.rawValue), окна \(windowsState.rawValue).\n")
    }
    
    let type: TypeCar = .trunk
    let model: String
    private let trunkVolume: Int
    var engineState: EngineState = .off {
        willSet {
            print("Двигатель \(newValue.rawValue)")
        }
    }
    var windowsState: WindowsState = .close {
        willSet {
            print("Окна \(newValue.rawValue)")
        }
    }
    
    init(model: String, trunkVolume: Int) {
        self.model = model
        self.trunkVolume = trunkVolume
        
        print("Авто \(model) создан!")
    }
    
}

class SportCar: Car, CustomStringConvertible {
    var description: String {
        return ("Это \(model) - \(type.rawValue) автомобиль с максимальной скоростью \(maxSpeed) км в час.\n Сейчас двигатель \(engineState.rawValue), окна \(windowsState.rawValue).\n")
    }
    let type: TypeCar = .sport
    let model: String
    private let maxSpeed: Int
    var engineState: EngineState = .off {
        willSet {
            print("Двигатель \(newValue.rawValue)")
        }
    }
    var windowsState: WindowsState = .close {
        willSet {
            print("Окна \(newValue.rawValue)")
        }
    }
    
    init(model: String, maxSpeed: Int) {
        self.model = model
        self.maxSpeed = maxSpeed
        
        print("Авто \(model) создан!")
    }
    
}
