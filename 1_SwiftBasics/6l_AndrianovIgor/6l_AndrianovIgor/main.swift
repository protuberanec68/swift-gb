//
//  main.swift
//  6l_AndrianovIgor
//
//  Created by Игорь Андрианов on 29.07.2021.
//

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

import Foundation

var queueHourse = Queue<Hourse>()
var queueBear = Queue<Bear>()

queueBear.push(Bear(height: 2.3, mass: 340, clawLength: 12.5))
queueBear.push(Bear(height: 2.1, mass: 230, clawLength: 10.5))
queueBear.push(Bear(height: 1.5, mass: 100, clawLength: 7.0))

print("_______")
print("Масса - \(String(describing: queueBear[0]?.mass))")
print("Масса - \(String(describing: queueBear[10]?.mass))")
print("_______")

//создаем новую очередь по фильтру существующей
var queueBear2 = queueBear.filtered { $0.height > 2.2 }
if let bear = queueBear2.pop() {
    print("Индекс массы тела - \(bear.calcBMI())")
}
print("_______")

//удаляем элементы по фильтру
queueBear.filter { $0.height > 2 }
//тест с попыткой изъятия элемента из пустой очереди
for _ in (0...4) {
    if let bear = queueBear.pop() {
        print("Индекс массы тела - \(bear.calcBMI())")
    }
}

