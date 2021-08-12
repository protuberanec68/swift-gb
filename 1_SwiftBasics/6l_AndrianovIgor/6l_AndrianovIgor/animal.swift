//
//  animal.swift
//  6l_AndrianovIgor
//
//  Created by Игорь Андрианов on 29.07.2021.
//

import Foundation

// MARK: протокол животное

protocol AnimalProtocol {
    var height: Double { get set }
    var mass: Double { get set }
}

// MARK: класс лошадь

class Hourse: AnimalProtocol {
    var height: Double
    var mass: Double
    let breed: String
    
    func calcBMI() -> Double {
        return self.height / self.mass
    }
    
    init(height: Double, mass: Double, breed: String) {
        self.height = height
        self.mass = mass
        self.breed = breed
    }
}

// MARK: класс медведь

class Bear: AnimalProtocol {
    var height: Double
    var mass: Double
    var clawLength: Double
    
    func calcBMI() -> Double {
        return self.height / self.mass
    }
    
    init(height: Double, mass: Double, clawLength: Double ) {
        self.height = height
        self.mass = mass
        self.clawLength = clawLength
    }
}
