//
//  queue.swift
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

// MARK: очередь

struct Queue<T: AnimalProtocol> {
    var queue: [T] = []
    
    mutating func push(_ element: T) {
        self.queue.append(element)
    }
    
    mutating func pop() -> T? {
        guard self.queue.count > 0 else { return nil }
        return self.queue.removeFirst()
    }
    
    // MARK: функция возвращает новую отфильтрованную очередь
    
    func filtered(predicate: (T) -> Bool ) -> (Queue) {
        var tempQueue = Queue()
        for item in self.queue {
            if predicate(item) {
                tempQueue.push(item)
            }
        }
        return tempQueue
    }
    
    // MARK: удаление элементов очереди по фильтру
    
    mutating func filter(predicate: (T) -> Bool ) -> () {
        var tempArray:[T] = []
        for item in self.queue {
            if predicate(item) {
                tempArray.append(item)
            }
        }
        self.queue = tempArray
    }
    
    // MARK: сабскрипт
    
    subscript(index: Int) -> T? {
        guard index < queue.count else { return nil }
        return queue[index]
    }
}
