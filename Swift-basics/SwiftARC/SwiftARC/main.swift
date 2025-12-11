var playground = true

class Student {
    unowned var teacher : Teacher?
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    deinit { print("goodbye student")}
    
}

class Teacher {
    var student : Student!
    var test : (() -> ())?
    
    lazy var test2 : (Bool) -> () = {(a: Bool) in
        print(self.student)
    }
    
    init(){
        student = Student(teacher: self)
    }
    
    deinit { print("goodbye teacher")}
    
    
}

var closure : (() -> ())?

if playground {
    
    var teacher = Teacher()
//    if playground {
//        
//        var student = Student(teacher: teacher)
//        teacher.student = student
//        student.teacher = teacher
//        print("exit playground")
//    }
    
    
    
    closure = {
        [unowned teacher] in
        print(teacher)
    }
    
    
    
    
    print("exit playground")
}

var x = 10
var y = 20

class Human {
    var name = "a"
}

var h = Human()


//var closure : () -> () = {
//    [x, y] in
//    print("\(x) \(y)")
//}

var closure2 : (Int) -> Int = { [x, y, h] (a: Int) -> Int in
    print("\(x) \(y) \(h.name)")
    return a
}

closure2(1)

x = 30
y = 40
h = Human()
h.name = "b"

closure2(1)


print("end")
