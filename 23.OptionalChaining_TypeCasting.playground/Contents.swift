import Foundation

class Adress {
    
    var street = "Deribasovskaya"
    var number = "1"
    var city = "Odessa"
    var country = "Ukraine"
}


class Garage {
    var size = 2
}

class House {
    var rooms = 1
    var adress = Adress()
    var garage : Garage? = Garage()
}

class Car {
    var model = "Zaporojec"
    
    func start() {
    }
}

class Person {
    
    var cars : [Car]? = [Car()]
    var house : House? = House()
}

let p = Person()

//p.cars![0]
//p.house!.garage!.size

p.house?.garage?.size = 3

if (p.house?.garage?.size = 3) != nil {
    print("upgrade")
} else {
    print("fail")
}






class Symbol {
    
}

class A : Symbol {
    func aa(){}
}

class B : Symbol {
    func bb(){}
}


let array : [Any] = [A(), B(), Symbol(), A(), B(), A(), 5, "s", {()->() in return}]


var aCount = 0
var bCount = 0
var sCount = 0

for value in array {
    if value is A {
        aCount += 1
    } else if value is B {
        bCount += 1
    } else {
        sCount += 1
    }
    
    
    if let a = value as? A {
        a.aa()
    } else if let b = value as? B {
        b.bb()
    }
    
    
    if let fun = value as? ()->() {
        print("okak")
    }
}
