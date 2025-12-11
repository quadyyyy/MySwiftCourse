class StudentClass {
    
    var name : String?
    var age : Int?
    
    init() {
        name = "No name"
        age = 20
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


struct StudentStruct {
    var name : String?
    var age : Int?
}


func addOneYear(student: StudentClass) {
    student.age! += 1
}

//func addOneYear1(var student: StudentStruct) {
//    student.age! += 1
//}

var stClass1 = StudentClass(name: "Bob", age: 18)
stClass1.name = "Alex"
stClass1.age = 21

var stStruct1 = StudentStruct(name: "Sam", age: 24)

var stStruct2 = stStruct1 // произошло копирование первой структуры
stStruct2.age = 25
stStruct2.name = "Sammy"

var stClass2 = stClass1 // копирования не произошло, это указатель
stClass2.age = 20
stClass2.name = "AAAA"

// суть в том, что структуры копируются, а классы указываются

// homework

// task 1

struct Student {
    let name : String
    let surname : String
    var age: Int
    var average: Float
    
}

let student1 = Student(name: "Bob", surname: "Robinson", age: 21, average: 4.9)
let student2 = Student(name: "Alice", surname: "Vance", age: 19, average: 4.1)
let student3 = Student(name: "Andrew", surname: "Popov", age: 20, average: 3.8)
let student4 = Student(name: "Roman", surname: "Kane", age: 18, average: 4.3)

var studentsJournal = [student1, student2, student3, student4]
print("task 1 \(studentsJournal)")


func task1(array: [Student]) -> Void {
    var number = 1
    for student in array {
        print("\(number). Name: \(student.name), age: \(student.age), average: \(student.average)")
        number += 1
    }
}

task1(array: studentsJournal)


// task 2

func task2(array: [Student]) -> Void {
    var number = 1
    var sortedArray = array.sorted { $0.average > $1.average}
    for student in sortedArray {
        print("\(number). Name: \(student.name), age: \(student.age), average: \(student.average)")
        number += 1
    }
}

task2(array: studentsJournal)

// task 3 - аналогично второму

// task 4

var studentJournal1 = studentsJournal
studentJournal1[0].average = 5
studentJournal1[1].average = 3
print(studentJournal1)

// task 1-4 (classes)

class Student1 {
    let name : String
    var age : Int
    var average : Float
    
    init(name: String, age: Int, average: Float) {
        self.name = name
        self.age = age
        self.average = average
    }
}


var student11 = Student1(name: "Alice", age: 19, average: 4.1)
var student22 = Student1(name: "Bob", age: 20, average: 3.8)
var student33 = Student1(name: "Roman", age: 18, average: 4.3)
var student44 = Student1(name: "David", age: 17, average: 3.9)

var studentsJournal11 = [student11, student22, student33, student44]


func task11(array: [Student1]) -> Void {
    var number = 1
    for student in array {
        print("\(number). Name: \(student.name), age: \(student.age), average: \(student.average)")
        number += 1
    }
}

task11(array: studentsJournal11)


func task21(array: [Student1]) -> Void {
    var number = 1
    var sortedArray = array.sorted { $0.average > $1.average}
    for student in sortedArray {
        print("\(number). Name: \(student.name), age: \(student.age), average: \(student.average)")
        number += 1
    }
}
task21(array: studentsJournal11)

var studentJournal111 = studentsJournal11
studentJournal111[0].average = 5
studentJournal111[1].average = 3
task11(array: studentJournal111)
