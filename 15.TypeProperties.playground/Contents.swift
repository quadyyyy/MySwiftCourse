
let MaxNameLenght = 20

//class Human {
//    var name : String {
//        didSet {
//            if name.count > MaxNameLenght {
//                name = oldValue
//            }
//        }
//    }
//    
//    class var maxAge : Int {
//        return 100
//    }
//    
//    lazy var storyOfMyLife = "This is a story of my entire life..."
//    
//    var age : Int {
//        didSet { if age > Human.maxAge { age = oldValue }}
//    }
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}

enum Direction {
    
    static let enumDescription = "Directions in the game"
    
    case Left
    case Right
    case Top
    case Bottom
    
    var isVertical : Bool {
        return self == .Top || self == .Bottom
    }
    
    var isHorizontal : Bool {
        return !isVertical
    }
}

let d = Direction.Right
print(d.isVertical, d.isHorizontal)


struct Cat {
    var name : String {
        didSet {
            if name.count > MaxNameLenght {
                name = oldValue
            }
        }
    }
    
    static let maxAge = 20
    
    nonisolated(unsafe) static var totalCats = 0
    
    var age : Int {
        didSet {
            if age > Cat.maxAge {
                age = oldValue
            }
        }
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        Cat.totalCats += 1
    }
}

//let human = Human(name: "Peter", age: 40)
let cat = Cat(name: "Whiten", age: 10)



// homework

// task 1

struct FileDescription {
    static let forbiddenSymbols : String = "*:<> "
    static let maxFileSize : Int = 2163879
    enum Visibility {
        case visible
        case hidden
    }
    
    var path : String {
        didSet {
            var hasForbidden = false
            
            for char in path {
                if FileDescription.forbiddenSymbols.contains(char) {
                    hasForbidden = true
                    break
                }
            }
            if hasForbidden == true { print("Symbols is forbidden"); path = oldValue }
        }
    }
    var name : String {
        didSet {
            var hasForbidden = false
            
            for char in name {
                if FileDescription.forbiddenSymbols.contains(char) {
                    hasForbidden = true
                    break
                }
            }
            if hasForbidden == true { print("Symbols is forbidden"); name = oldValue }
        }
    }
    
    var filesize : Int { didSet { if FileDescription.maxFileSize < filesize { print("File is too big, reverting"); filesize = oldValue }}}
    var visibility : Visibility
    lazy var content : String! = "This is a very very good and interesting file"
}


// task 2

enum Gamma: UInt32, CaseIterable {
    
    static let amountOfColors : Int = allCases.count
    
    case green = 0x00FF00
    case red   = 0xFF0000
    case blue  = 0x0000FF
    
    static var startColor : Gamma {
        get { return allCases.first!}
    }
    
    static var endColor : Gamma {
        get { return allCases.last!}
    }
}


// task 3

class Human {
    nonisolated(unsafe) static var humanClassesAmount : Int = 0
    static let maxLengthOfName : Int = 14
    static let minLenghtOfName : Int = 2
    static let maxWeight : Int = 550
    static let maxAge : Int = 120
    
    var name : String {
        didSet { if name.count > Human.maxLengthOfName || name.count < Human.minLenghtOfName { name = oldValue }}
    }
    
    var age : Int {
        didSet { if age > Human.maxAge { age = oldValue }}
    }
    
    var weight : Int {
        didSet { if weight > Human.maxWeight { weight = oldValue }}
    }
    
    init(name: String, age: Int, weight: Int) {
        self.name = name
        self.age = age
        self.weight = weight
        Human.humanClassesAmount += 1
    }
}
