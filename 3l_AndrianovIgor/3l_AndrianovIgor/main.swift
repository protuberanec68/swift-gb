//
//  main.swift
//  3l_AndrianovIgor
//
//  Created by Игорь Андрианов on 19.07.2021.
//

import Foundation


//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

var carLada = SportCar(brand: "Лада", year: 1990, volumeOfTrunk: 300)
var carFiat = SportCar(brand: "FIAT", year: 123, volumeOfTrunk: 10000)
var carKamaz = TrunkCar(brand: "Камаз", year: 2004, volumeOfTrunk: 15000)
print("________________")
carLada?.printInfoCar()
carLada?.printStateCar()
carLada?.printStateTrunk()
print("________________")
carLada?.makeAction(.closeWindows)
carLada?.makeAction(.openWindows)
carLada?.makeAction(.stopEngine)
carLada?.makeAction(.startEngine)
carLada?.printStateCar()
print("________________")
carLada?.makeAction(.unloadCargoFull)
carLada?.makeAction(.loadCargoFull)
carLada?.makeAction(.unloadCargoFull)
carLada?.makeAction(.unloadCargo100)
carLada?.makeAction(.loadCargoFull)
carLada?.makeAction(.loadCargo100)
print("________________")
carFiat?.printInfoCar()
print("________________")
carKamaz?.printInfoCar()
carKamaz?.printStateCar()
carKamaz?.printStateTrunk()
print("________________")
carKamaz?.makeAction(.load(.hundred))
print("________________")
carKamaz?.makeAction(.engine(.running))
carKamaz?.makeAction(.engine(.stopped))
print("________________")
carKamaz?.makeAction(.windows(.closed))
carKamaz?.makeAction(.windows(.opened))
carKamaz?.makeAction(.windows(.opened))
print("________________")
carKamaz?.makeAction(.load(.full))
carKamaz?.makeAction(.load(.hundred))
carKamaz?.makeAction(.unload(.full))
