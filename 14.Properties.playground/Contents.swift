import Foundation


struct Student {
    var firstName : String {
        didSet {
            print("did set \(firstName) instead of \(oldValue)")
            
            firstName = firstName.capitalized
        }
    }
    
    var lastName : String {
        didSet {
            lastName = lastName.capitalized
        }
    }
    
    var fullName : String {
        get {
            return firstName + " " + lastName
        }
        set {
            print("fullName wants to be set to \(newValue)")
            
            let words = newValue.components(separatedBy: .whitespaces)
            
            if words.count > 0 {
                firstName = words[0]
            }
            
            if words.count > 1 {
                lastName = words[1]
            }
            
        }
    }
    
    var dayOfBirth : Int
    var monthOfBirth : Int
    var yearOfBirth : Int
    
    var age : Int {
        get {
            let day = 26
            let month = 9
            let year = 2025
            var calculatedage = year - yearOfBirth
            
            if month < monthOfBirth || (month == monthOfBirth && day < dayOfBirth) {
                calculatedage -= 1
            }
            return calculatedage
        }
    }
    
    var studyTime : Int {
        get {
            if age > 6 {
                return age - 6
            } else { return 0 }
        }
    }
    
    
}


// task 3

struct Point {
    var x : Int
}

struct Segment {
    var pointA: Point
    var pointB: Point
    
    var midPoint : Int {
        get { return (pointA.x+pointB.x)/2 }
        set {
            let oldMid = midPoint
            let delta = newValue - oldMid
            pointA.x = pointA.x + delta
            pointB.x = pointB.x + delta
        }
    }
    
    var length : Int {
        get { return abs(pointA.x-pointB.x) }
        set {
            let oldLenght = length
            let delta = newValue - oldLenght
            pointB.x = pointB.x + delta
        }
    }
    
}
