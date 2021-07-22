//
//  TrunkCar.swift
//  3l_AndrianovIgor
//
//  Created by Игорь Андрианов on 19.07.2021.
//

import Foundation

//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

//Реализация ver.2
struct TrunkCar {
    let type = "Грузовой авто"
    let brand: String
    let year: Int
    let volumeOfTrunk: Int
    private var age:Int {
        get {
            Limits.endYear.rawValue - year
        }
    }
    private var isEngineRunning: EngineState {
        willSet {
                print("Двигатель \(self.brand) \(newValue.rawValue).")
        }
    }
    private var isWindowsClosed: WindowsState {
        willSet {
                print("Окна \(self.brand) \(newValue.rawValue).")
        }
    }
    private var volumOfCargo: Int {
        didSet {
            self.printStateTrunk()
        }
}
    
    init? (brand: String, year: Int, volumeOfTrunk: Int) {
        var error = false
        var errorMsg = "Неверные вводные данные по авто \(brand).\n"
        self.brand = brand
        if Limits.startYear.rawValue > year || year > Limits.endYear.rawValue {
            errorMsg += " Недопустимый год выпуска авто - \(year) (допустимо от \(Limits.startYear.rawValue) до \(Limits.endYear.rawValue))."
            error = true
            self.year = Limits.startYear.rawValue
        } else {
            self.year = year
        }
        
        if Limits.startLimitTrunk.rawValue > volumeOfTrunk || volumeOfTrunk >= Limits.endLimitTrunkForTrunk.rawValue {
            errorMsg += " Недопустимый объем кузова - \(volumeOfTrunk) (не более \(Limits.endLimitTrunkForSport.rawValue))."
            error = true
            self.volumeOfTrunk = Limits.startLimitTrunk.rawValue
        } else {
            self.volumeOfTrunk = volumeOfTrunk
        }
        
        self.isEngineRunning = .stopped
        self.isWindowsClosed = .closed
        self.volumOfCargo = 0
        
        if error {
            print(errorMsg)
            return nil
        } else {
            print("Авто \(self.brand) создан!")
        }
    }
    
    func printInfoCar() {
        print("\(self.type) \(self.brand) \(self.year) года выпуска. Машине \(self.age) лет.")
    }
    
    func printStateTrunk() {
        print("В кузове \(self.brand) объемом \(self.volumeOfTrunk) лежит груз объемом \(self.volumOfCargo) литров.")
    }
    
    func printStateCar() {
        print("Двигатель \(self.brand) \(self.isEngineRunning.rawValue), окна \(self.isWindowsClosed.rawValue).")
    }
    
    mutating func makeAction(_ action: TrunkCarActions) {
        switch action {
        case .engine (let doing):
            self.isEngineRunning = doing
        case .windows (let doing):
            self.isWindowsClosed = doing
        case .load (let volume):
            if self.volumeOfTrunk <= volume.rawValue + self.volumOfCargo {
                self.volumOfCargo = self.volumeOfTrunk
            } else {
                self.volumOfCargo += volume.rawValue
            }
        case .unload (let volume):
            if 0 >= self.volumOfCargo - volume.rawValue {
                self.volumOfCargo = 0
            } else {
                self.volumOfCargo -= volume.rawValue
            }
        }
    }
}
