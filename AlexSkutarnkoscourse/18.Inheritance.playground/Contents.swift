import Foundation

class Human {
    var firstName : String = ""
    var lastName : String = ""
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
    
    func sayHello() -> String {
        return "Hello"
    }
}

class SmartHuman : Human {
    
}

class Student : SmartHuman {
    override func sayHello() -> String {
        return super.sayHello() + " my friend"
    }
}

class Kid : Human {
    
    var favoriteToy : String = "iMac"
    override func sayHello() -> String {
        return "agu"
    }
    
    override var fullName: String {
        return firstName
    }
    
    override var firstName: String {
        set {
            super.firstName = newValue + " :)"
        }
        get {
            return super.firstName
        }
    }
    
    override var lastName: String {
        didSet { print("new value = \(self.lastName)") }
    }
}


let human = Human()
human.firstName = "John"
human.lastName = "Doe"
print(human.sayHello())

let student = Student()
student.firstName = "Max"
student.lastName = "Doe"
print(student.sayHello())

let kid = Kid()
print(kid.sayHello())
print(kid.favoriteToy)


let humans : [Human] = [human, kid, student]


// homework

// task 1

class Artist {
    var firstName : String = " "
    var lastName : String = " "
    var fullName : String { return "\(firstName) \(lastName)" }
    var performance : String = " "
    
    func returnPerformance() -> String {
        return ("\(fullName) is performing ")
    }
}

class Clown : Artist {
    override func returnPerformance() -> String {
        return super.returnPerformance( ) + "jokes"
    }
}

class Dancer : Artist {
    override func returnPerformance() -> String {
        return super.returnPerformance( ) + "choreography"
    }
}

class Singer : Artist {
    override func returnPerformance() -> String {
        return super.returnPerformance( ) + "songs"
    }
}

class Painter : Artist {
    override var fullName: String { return "John Doe" }
    override func returnPerformance() -> String {
        return super.returnPerformance() + "art"
    }
}

let clown = Clown()
clown.firstName = "Oleg"
clown.lastName = "Ivan"

let dancer = Dancer()
dancer.firstName = "Max"
dancer.lastName = "Maxon"

let singer = Singer()
singer.firstName = "Jay"
singer.lastName = "Dee"

let painter = Painter()
painter.firstName = "Ben"
painter.lastName = "Jim"



let artists : [Artist] = [clown, dancer, singer, painter]

for artist in artists {
    print(artist.returnPerformance())
}



// task 2

class Vehicle {
    let speed : Int
    let passengers : Int
    let pricePerKilometer : Double
    var timePerKilometer: Double { return 60.0 / Double(speed) } // in minutes

    
    func overallPrice(amountOfPassengers: Int, distance: Int) -> (trips: Int, price: Double, time: Double) {
        
        var numberOfTrips: Int {
            return Int(ceil(Double(amountOfPassengers) / Double(passengers)))
        }
        
        return (numberOfTrips, (pricePerKilometer*Double(distance)*Double(numberOfTrips)), (timePerKilometer*Double(distance)*Double(numberOfTrips)))
        
    }
    
    
    init(speed: Int, passengers: Int, pricePerKilometer: Double) {
        self.speed = speed
        self.passengers = passengers
        self.pricePerKilometer = pricePerKilometer
    }
}

class Bus : Vehicle {
    
}

class Plane : Vehicle {
    
}

class Train : Vehicle {
    
}


let bus = Bus(speed: 60, passengers: 45, pricePerKilometer: 0.05)
let plane = Plane(speed: 850, passengers: 300, pricePerKilometer: 0.09)
let train = Train(speed: 80, passengers: 510, pricePerKilometer: 0.1)
let passengers = 1000
let distance = 500


let busResult = bus.overallPrice(amountOfPassengers: passengers, distance: distance)
let planeResult = plane.overallPrice(amountOfPassengers: passengers, distance: distance)
let trainResult = train.overallPrice(amountOfPassengers: passengers, distance: distance)


print("Bus: trips \(busResult.trips), price \(busResult.price), time \(busResult.time) minutes")
print("Plane: trips \(planeResult.trips), price \(planeResult.price), time \(planeResult.time) minutes")
print("Train: trips \(trainResult.trips), price \(trainResult.price), time \(trainResult.time) minutes")

// кто быстрее
let minTime = min(busResult.time, planeResult.time, trainResult.time)
if minTime == busResult.time {
    print("Bus is the fastest")
} else if minTime == planeResult.time {
    print("Plane is the fastest")
} else {
    print("Train is the fastest")
}

// кто дешевле
let minPrice = min(busResult.price, planeResult.price, trainResult.price)
if minPrice == busResult.price {
    print("Bus is the cheapest")
} else if minPrice == planeResult.price {
    print("Plane is the cheapest")
} else {
    print("Train is the cheapest")
}

