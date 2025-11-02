import Foundation

class Student2 {
    var firstName = ""
    var lastName = ""
}

class Student3 {
    var firstName : String
    var lastName : String
    
    init(_ firstName: String, _ lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Student4 {
    var middleName: String?
}


// константы можно задать в инициализаторе
class Student5 {
    let maxage : Int
    
    init() {
        maxage = 100
    }
}

//class Student6 : Student5 {
//    override init () {
//        super.maxage = 110
//    }
//}

struct Student7 {
    var firstName : String
    var lastName : String
}

class Human {
    var weight : Int
    var age : Int
    
    init(weight: Int, age: Int) {
        self.weight = weight
        self.age = age
    }
    
    convenience init(age: Int){
        self.init(weight: 0, age: age)
    }
    
    convenience init(weight: Int){
        self.init(weight: weight, age: 0)
    }
    
    convenience init() {
        self.init(weight: 0)
    }
}

let student = Student3("asd", "sadasd")

class Student : Human {
    var firstName : String
    var lastName : String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        super.init(weight: 0, age: 0)
        
        self.weight = 50
    }
    
    convenience init(firstName: String) {
        self.init(firstName: firstName, lastName: "")
        self.age = 28
    }
    
    override convenience init(weight: Int, age: Int) {
        self.init(firstName: "")
        self.weight = weight
        self.age = age
    }
}


class Doctor : Student {
    
    var fieldOfStudy : String
    
    init(fieldOfStudy: String) {
        self.fieldOfStudy = fieldOfStudy
        super.init(firstName: "Doctor", lastName: "House")
    }
    
//    convenience init(fieldOfStudy: String) {
//        self.init(firstName: "Doctor", lastName: "House")
//        self.fieldOfStudy = fieldOfStudy
//    }
    
    override init(firstName: String, lastName: String) {
        self.fieldOfStudy = "Medicine"
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(firstName: String) {
        self.init(fieldOfStudy: "Math")
        self.age = 35
        self.firstName = firstName
    }
}


let d1 = Doctor(firstName: "aaaa")


enum Color : Int {
    case Black
    case White
    
    init?(_ value: Int) {
        switch value {
        case 0: self = .Black
        case 1: self = .White
        default: return nil
        }
    }
}

let a = Color(-1)
let b = Color(rawValue: 1)


struct Size {
    var width : Int
    var height : Int
    
    init?(width: Int, height: Int) {
        self.width = width
        if height < 0 {
            return nil
        }
        self.height = height
    }
}

class Friend : Human {
    var name : String!
    
    var skin : Color = {
        let random = Int(arc4random_uniform(2))
        return Color(random)!
    }()
    
    init?(name: String) {
        self.name = name
        super.init(weight: 0, age: 0)
        if name.isEmpty {
            return nil
        }
    }
    
    
    required init() {
        self.name = "hi"
        super.init(weight: 0, age: 0)
    }
    
}

class BestFriend : Friend {
    override init(name: String) {
        if name.isEmpty {
            super.init()
        } else {
            super.init(name: name)!
        }
        
    }
    
    required init() {
        super.init()
    }
    
    
    deinit {
        print("BestFriend deinitialized")
    }
}

struct Test {
    var bestfriend : BestFriend? = BestFriend(name: "")
}

var test : Test? = Test()

test!.bestfriend = nil

