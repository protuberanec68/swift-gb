//
//  enum.swift
//  4l_AndrianovIgor
//
//  Created by Игорь Андрианов on 21.07.2021.
//

import Foundation

enum CarActions {
    case engine(EngineState)
    case windows(WindowsState)
    case nitro(NitroState)
    case trunk(TrunkState)
}

enum EngineState: String {
    case on = "включен", off = "выключен"
}

enum WindowsState: String {
    case open = "открыты", close = "закрыты"
}

enum NitroState: String {
    case on = "включено", off = "выключено"
}

enum TrunkState: String {
    case full = "полный", empty = "пустой"
}
