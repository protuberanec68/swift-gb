//
//  code.swift
//  3l_AndrianovIgor
//
//  Created by Игорь Андрианов on 19.07.2021.
//

import Foundation

//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.

//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

//Реализация ver.1
struct SportCar {
    let type = "Легковой авто"
    let brand: String
    let year: Int
    let volumeOfTrunk: Int
    private var isEngineRunning: EngineState
    private var isWindowsClosed: WindowsState
    private var volumOfCargo: Int
    
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
        
        if Limits.startLimitTrunk.rawValue > volumeOfTrunk || volumeOfTrunk >= Limits.endLimitTrunkForSport.rawValue {
            errorMsg += " Недопустимый объем багажного отделения - \(volumeOfTrunk) (не более \(Limits.endLimitTrunkForSport.rawValue))."
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
        print("\(self.type) \(self.brand) \(self.year) года выпуска.")
    }
    
    func printStateTrunk() {
        print("В багажнике \(self.brand) объемом \(self.volumeOfTrunk) лежит груз объемом \(self.volumOfCargo) литров.")
    }
    
    func printStateCar() {
        print("Двигатель \(self.brand) \(self.isEngineRunning.rawValue), окна \(self.isWindowsClosed.rawValue).")
    }
    
    mutating func makeAction(_ action: SportCarActions) {
        switch action {
        case .startEngine:
            if self.isEngineRunning == .stopped {
                print("Двигатель \(self.brand) \(EngineState.running.rawValue).")
                self.isEngineRunning = .running
            } else {
                print("Двигатель уже \(self.brand) \(EngineState.running.rawValue).")
            }
        case .stopEngine:
            if self.isEngineRunning == .running{
                print("Двигатель \(self.brand) \(EngineState.stopped.rawValue).")
                self.isEngineRunning = .stopped
            } else {
                print("Двигатель \(self.brand) \(EngineState.stopped.rawValue).")
            }
        case .openWindows:
            if self.isWindowsClosed == .closed {
                print("Окна \(self.brand) \(WindowsState.opened.rawValue).")
                self.isWindowsClosed = .opened
            } else {
                print("Окна \(self.brand) уже \(WindowsState.opened.rawValue).")
            }
        case .closeWindows:
            if self.isWindowsClosed == .opened {
                print("Окна \(self.brand) \(WindowsState.closed.rawValue).")
                self.isWindowsClosed = .closed
            } else {
                print("Окна \(self.brand) уже \(WindowsState.closed.rawValue).")
            }
        case .loadCargo100:
            if self.volumOfCargo + 100 <= self.volumeOfTrunk {
                self.volumOfCargo += 100
                print("Груз объемом 100 литров помещен в багажник \(self.brand).")
                self.printStateTrunk()
            } else {
                print("Груз в багажник \(self.brand) не помещается.")
            }
        case .loadCargoFull:
            self.volumOfCargo = self.volumeOfTrunk
            print("Багажник \(self.brand) заполнен.")
        case .unloadCargo100:
            if self.volumOfCargo - 100 >= 0 {
                self.volumOfCargo -= 100
                print("Груз объемом 100 литров вынут из багажника \(self.brand).")
                self.printStateTrunk()
            } else {
                print("Мы все выгрузили из \(self.brand).")
                self.volumOfCargo = 0
            }
        case .unloadCargoFull:
            self.volumOfCargo = 0
            print("Багажник \(self.brand) опустошен.")
        }
    }
}
