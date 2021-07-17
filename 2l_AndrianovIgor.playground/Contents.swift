import Foundation

//1. Написать функцию, которая определяет, четное число или нет.
func isNumEven(_ x:Int) -> Bool {
    let isEven = ((x % 2) == 0 ? true : false)
    return isEven
}

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isNumMultipleThree(_ x:Int) -> Bool {
    let isDiv = ((x % 3) == 0 ? true : false)
    return isDiv
}


//3. Создать возрастающий массив из 100 чисел.
var numArr = Array(1...100)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
/*--------------------ver.1 через проход массива с конца----------------------*/
for i in stride(from: numArr.count - 1, through: 0, by: -1) {
    if isNumEven(numArr[i]) || !isNumMultipleThree(numArr[i]) {
        numArr.remove(at: i)
    }
}
print("В первом массиве мы выбросили четные числа и все числа, которые не делятся на 3, и получили:")
print(numArr)

/*--------------------ver.2 через временный массив----------------------*/
var numArr2 = Array(1...100)

func delete2And3Nums(arr: inout [Int]){
    var exitArr:[Int] = []
    for num in arr {
        if !isNumEven(num) && isNumMultipleThree(num) {
            exitArr.append(num)
        }
    }
    arr = exitArr
}

delete2And3Nums(arr: &numArr2)


print("Во втором массиве мы выбросили четные числа и все числа, которые не делятся на 3, и получили:")
print(numArr2)

/*5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2. */
func addFibNums(toArrayInt array: inout [Int], howMuchNums limit:Int) {
    if limit > 2 {
        addFibNums(toArrayInt: &array, howMuchNums: limit - 1)
        array.append(array.suffix(2).reduce(0, +))
        return
    } else if limit == 2 {
        addFibNums(toArrayInt: &array, howMuchNums: limit - 1)
        array.append(1)
        return
    } else if limit == 1 {
        array.append(0)
        return
    } else {
        return
    }
}

addFibNums(toArrayInt: &numArr, howMuchNums: 50)

print("И добавили в массив 50 первых чисел Фибоначчи:")
print(numArr)

/*6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:

a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
b. Пусть переменная p изначально равна двум — первому простому числу.
c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
e. Повторять шаги c и d, пока возможно.
*/

var arrayOfStartNums:[Int?] = Array(2...600)
var p:Int
var arrayOfSimpleNums:[Int] = [2]

while arrayOfSimpleNums.count < 100 {
    p = arrayOfSimpleNums.last!
    for (index, value) in arrayOfStartNums.enumerated() {
        if value! % p == 0 {
            arrayOfStartNums[index] = nil
        }
    }
    var tempArr:[Int] = []
    for i in arrayOfStartNums {
        if let test = i {
            tempArr.append(test)
        }
    }
    arrayOfStartNums = tempArr
    arrayOfSimpleNums.append(arrayOfStartNums[0]!)
}

print("Выводим первые 100 простых чисел, высчитанных по методу Эратосфена:")
print(arrayOfSimpleNums)
