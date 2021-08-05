//
//  castle.swift
//  7l_AndrianovIgor
//
//  Created by Игорь Андрианов on 03.08.2021.
//

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

import Foundation

class Castle {
    private var lightState: OnOff = .off
    private var powerState: OnOff = .on
    private var lightSwitchState: OnOff = .off
    private var countOnLight: Int = 0
    
    func changeLightState() -> (Int, PowerError?) {
        guard self.powerState == .on else { return (countOnLight,
                                                    PowerError.powerOff) }
        self.lightState = (self.lightState == .off ? .on : .off)
        if self.lightState == .on {
            countOnLight += 1
        }
        return (countOnLight, nil)
    }
    
    func changePowerState() {
        self.powerState = (self.powerState == .off ? .on : .off)
        if self.powerState == .off {
            self.lightState = .off
        }
    }
}

enum OnOff {
    case on
    case off
}

enum PowerError: String, Error {
    case powerOff = "электричества нет"
}

typealias Result = (Int, PowerError?)
