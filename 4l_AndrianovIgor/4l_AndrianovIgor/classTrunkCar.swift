//
//  classTrunkCar.swift
//  4l_AndrianovIgor
//
//  Created by Игорь Андрианов on 21.07.2021.
//

import Foundation

final class TrunkCar: Car {
    let trunkVolume: Int
    private var trunkState: TrunkState = .empty {
        willSet {
            print("Кузов \(self.model) \(newValue.rawValue)")
        }
    }
    
    init(model: String, weight: Int, enginePower: Int, trunkVolume: Int){
        self.trunkVolume = trunkVolume
        
        super.init(model: model, weight: weight, enginePower: enginePower)
    }
    
    override func carAction(action: CarActions) {
        switch action {
        case .trunk (let option):
            trunkState = option
        default:
            super.carAction(action: action)
        }
    }
    
    override func printProperties() {
        super.printProperties()
        print("Кузов \(self.model) объемом \(self.trunkVolume) литров.")
    }
}
