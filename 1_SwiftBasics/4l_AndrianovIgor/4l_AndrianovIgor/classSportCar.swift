//
//  classSportCar.swift
//  4l_AndrianovIgor
//
//  Created by Игорь Андрианов on 21.07.2021.
//

import Foundation

final class SportCar: Car {
    let maxSpeed: Int
    private var nitroState: NitroState = .off {
        willSet {
            print("Нитро \(self.model) \(newValue.rawValue)")
        }
    }
    
    init(model: String, weight: Int, enginePower: Int, maxSpeed: Int){
        self.maxSpeed = maxSpeed
        
        super.init(model: model, weight: weight, enginePower: enginePower)
    }
    
    override func carAction(action: CarActions) {
        switch action {
        case .nitro (let option):
            nitroState = option
        default:
            super.carAction(action: action)
        }
    }
    
    override func printProperties() {
        super.printProperties()
        print("Максимальная скорость \(self.model) - \(self.maxSpeed) км в час.")
    }
}
