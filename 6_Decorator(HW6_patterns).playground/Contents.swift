import UIKit

protocol Coffee{
    var cost: Int { get }
}

protocol CoffeeDecorator: Coffee{
    var base: Coffee { get }
    init(base: Coffee)
}

class SimpleCoffee: Coffee{
    let cost = 20
}

class Milk: CoffeeDecorator{
    let base: Coffee
    
    var cost: Int {
        return base.cost + 3
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator{
    let base: Coffee
    
    var cost: Int {
        return base.cost + 2
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Sugar: CoffeeDecorator{
    let base: Coffee
    
    var cost: Int {
        return base.cost + 1
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Cinnamon: CoffeeDecorator{
    let base: Coffee
    
    var cost: Int {
        return base.cost + 3
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

let coffee = SimpleCoffee()
let sugarCoffee = Sugar(base: coffee)
let cinnSugarCoffee = Cinnamon(base: sugarCoffee)
let whipCoffee = Whip(base: coffee)
let doubleWhipCoffee = Whip(base: whipCoffee)

print("Coffee costs \(coffee.cost)")
print("Coffee + sugar costs \(sugarCoffee.cost)")
print("Coffee + cinnamon costs \(cinnSugarCoffee.cost)")
print("Coffee + whip costs \(whipCoffee.cost)")
print("Coffee + whip + whip costs \(doubleWhipCoffee.cost)")
