import Foundation

//1. Решить квадратное уравнение.
let a = 6.0
let b = 10.0
let c = -1.0
let d = pow(b, 2) - 4*a*c
if d > 0 {
    print("Первый корень равен \((-b-sqrt(d))/2/a), второй равен \((-b+sqrt(d))/2/a)")
}
else if d == 0 {
    print("Корень один и он равен \(-b/2/a)")
}
else {
    print("Корней нет")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
let katetA = 5.0
let katetB = 7.0

let area = katetA * katetB / 2
let hypo = sqrt(pow(katetA, 2) + pow(katetB, 2))
let perimeter = hypo + katetA + katetB
print("Правильный треугольник с катетами \(katetA) и \(katetB) имеет площадь \(area), периметр \(Float(perimeter)) и гипотенузу \(Float(hypo))")


//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
let deposit = 2000.0
let percent = 5.0
let years = 5
let finalMoney = deposit * pow((1.0 + percent/100), Double(years))
print("Ваш вклад в размере \(deposit) с процентной ставкой \(percent) через \(years) лет увеличится до \(String(format: "%.2f", finalMoney))")
