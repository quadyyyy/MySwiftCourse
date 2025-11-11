import Foundation

extension Int {
    var isEven : Bool {
        return self % 2 == 0
    }
    
    var isOdd : Bool {
        return !isEven
    }
    
    enum EvenOrOdd {
        case Even
        case Odd
    }
    
    var evenOrOdd : EvenOrOdd {
        return isOdd ? .Even : .Odd
    }
    
    func pow(_ value: Int) -> Int {
        var temp = self
        for _ in 1..<value {
            temp *= self
        }
        return temp
    }
    
    mutating func powTo(value: Int) {
        self = pow(value)
    }
    
    
    var binaryString : String {
        
        var result = ""
        for i in 0..<8 {
            result = String(self & (1 << i)) + result
        }
        
        return result
    }
}


extension String {
    init(_ value: Bool) {
        self.init(value ? 1 : 0)
    }
}


extension Int.EvenOrOdd {
    var string : String {
        switch self {
        case .Even: return "even"
        case .Odd: return "odd"
        }
    }
}

let a = 5

if a % 2 != 0 {
    print("a")
}


print(a.pow)
print(a.binaryString)


let s = "Hello world"

let start = s.startIndex
let end = s.index(start, offsetBy: 5)
s[start..<end]


//    subscript(start: Int, lenght: Int) -> String {
//        let start = self.index(self.startIndex, offsetBy: start)
//        let end = self.index(self.startIndex, offsetBy: lenght)
//        return String(self[start..<end])
//    }
