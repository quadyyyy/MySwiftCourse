
struct Point {
    var x : Int
    var y : Int
    
    mutating func moveByX(X: Int, andY: Int) {
        self = Point(x: self.x + X, y: self.y + andY)
    }
}

enum Color {
    case White
    case Black
    
    static func numberOfElements() -> Int {
        self
        return 2
    }
    
    mutating func invert() {
        if self == .White { self = .Black } else { self = .White }
    }
}

var c = Color.White
c.invert()
Color.numberOfElements()


func move(point: inout Point, byX: Int, andY: Int) -> Point {
    point.x += byX
    point.y += andY
    return point
}

var p = Point(x: 1, y: 1)
move(point: &p, byX: 2, andY: 4)
