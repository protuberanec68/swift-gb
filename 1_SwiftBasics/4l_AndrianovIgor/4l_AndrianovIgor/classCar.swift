//
//  classCar.swift
//  4l_AndrianovIgor
//
//  Created by Игорь Андрианов on 21.07.2021.
//

import Foundation

class Car {
    static var count = 0
    let model: String
    let weight: Int
    let enginePower: Int
    private var engineState: EngineState = .off {
        willSet {
            print("Двигатель \(newValue.rawValue)")
        }
    }
    private var windowsState: WindowsState = .close {
        willSet {
            print("Окна \(newValue.rawValue)")
        }
    }
    
    init(model: String, weight: Int, enginePower: Int) {
        self.model = model
        self.weight = weight
        self.enginePower = enginePower
        
        self.printProperties()
        Car.count += 1
        Car.printCount()
    }
    
    deinit {
        print("Экземпляр автомобиля уничтожен.")
        Car.count -= 1
        Car.printCount()
    }
    
    static func printCount() {
        print("В парке \(count) авто")
    }
    
    func carAction(action: CarActions) {
        switch action {
        case .engine (let option):
            engineState = option
        case .windows (let option):
            windowsState = option
        default:
            return
        }
    }
    
    func printProperties() {
        print("Автомобиль \(self.model) массой \(self.weight) обладает двигателем мощностью \(self.enginePower) л.с.")
        print("Сейчас двигатель \(self.engineState.rawValue).")
        print("Сейчас окна \(self.windowsState.rawValue).")
    }
}
