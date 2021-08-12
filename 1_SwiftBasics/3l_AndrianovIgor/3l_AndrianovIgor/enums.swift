//
//  enums.swift
//  3l_AndrianovIgor
//
//  Created by Игорь Андрианов on 19.07.2021.
//

import Foundation


//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.


/*---Перечисления для SportCar и TrunkCar---*/
enum EngineState: String {
    case running = "запущен"
    case stopped = "остановлен"
}

enum WindowsState: String {
    case opened = "открыты"
    case closed = "закрыты"
}

enum Limits: Int {
    case startYear = 1900
    case endYear = 2021
    case startLimitTrunk = 0
    case endLimitTrunkForSport = 2000
    case endLimitTrunkForTrunk = 20000
}

/*---Перечисление для SportCar---*/

enum SportCarActions {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadCargo100
    case loadCargoFull
    case unloadCargo100
    case unloadCargoFull
}


/*---Перечисления для TrunkCar---*/
enum TrunkCarActions {
    case engine(EngineState)
    case windows(WindowsState)
    case load(ValueOfCargoTrunkCar)
    case unload(ValueOfCargoTrunkCar)
}

enum ValueOfCargoTrunkCar: Int {
    case hundred = 100
    case full = 20000
}

