//
//  main.swift
//  L_6_Pavel_Shatunov
//
//  Created by Павел Шатунов on 26.03.2021.
//

import Foundation

enum CarType: String {
    case passenger = "легковая"
    case truck = "грузовая"
}

enum CarBody: String {
    case damaged, untact
}

enum CheckEngine: String {
    case yes, no
}

class Car: CustomStringConvertible {
    let release: Int
    let brand: String
    var checkEngine: CheckEngine
    var carBody: CarBody
    var type: CarType
    init(release: Int, brand: String, checkEngine: CheckEngine, carBody: CarBody, type: CarType) {
        self.release = release
        self.brand = brand
        self.checkEngine = checkEngine
        self.carBody = carBody
        self.type = type
    }
    var description: String {
        return " Марка \(brand) год выпуска \(release) Check engine \(checkEngine.rawValue) состояние кузова \(carBody.rawValue) тип авто \(type.rawValue) "
    }
}

struct QueueForService<T> {
    private var cars: [T] = []
    mutating func push(_ car: T) {
        cars.append(car)
    }
    mutating func pop() -> T? {
        guard cars.count > 0 else {return nil}
        return cars.removeLast()
    }
    func filter(predicate: (T) -> Bool) -> [T] {
        var carsFiltered: [T] = []
        for car in cars {
            if predicate(car) {
                carsFiltered.append(car)
            }
        }
        return carsFiltered
    }
    
    func map<S>(_ predicate: (_: T) -> S ) -> [S] {
             return self.cars.map(predicate)
        }
   
    subscript(index: Int) -> T? {
        guard cars.count > index && index >= 0 else {return nil}
        return cars[index]
    }
}

var carsStack = QueueForService<Car>()
carsStack.push(Car(release: 2015, brand: "BMW", checkEngine: .yes, carBody: .damaged, type: .passenger))
carsStack.push(Car(release: 2019, brand: "Mercedes", checkEngine: .no, carBody: .untact, type: .passenger))
carsStack.push(Car(release: 2005, brand: "MAN", checkEngine: .yes, carBody: .damaged, type: .truck))
carsStack.push(Car(release: 2020, brand: "Volvo", checkEngine: .no, carBody: .untact, type: .truck))
carsStack.push(Car(release: 2010, brand: "Porsche", checkEngine: .yes, carBody: .untact, type: .passenger))
let car2 = carsStack.filter {car in car.checkEngine == .yes}
print(car2[0].description)
carsStack[0]?.carBody = .untact

