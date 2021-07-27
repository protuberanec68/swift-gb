//
//  main.swift
//  4l_AndrianovIgor
//
//  Created by Игорь Андрианов on 21.07.2021.
//

import Foundation

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

//2. Описать пару его наследников TrunkCar и SportCar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. Добавить эти действия в перечисление.

//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

//6. Вывести значения свойств экземпляров в консоль.



var carSport: SportCar? = SportCar(model: "Мустанг", weight: 900, enginePower: 150, maxSpeed: 200)
print("__________________")
var carTrunk: TrunkCar? = TrunkCar(model: "Камаз", weight: 5000, enginePower: 250, trunkVolume: 1000)
print("__________________")
carSport?.carAction(action: .engine(.on))
carSport?.carAction(action: .nitro(.on))
carSport?.printProperties()
print("__________________")
carTrunk?.carAction(action: .trunk(.full))
print("_____")
carTrunk?.carAction(action: .nitro(.on))
print("_____")
carTrunk?.printProperties()
print("__________________")
carTrunk = nil
