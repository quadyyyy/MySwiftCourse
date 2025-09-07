//var dict = ["машина": "car", "человек": "human"]
//
//// methods
//dict.isEmpty
//dict.count
//
//dict["компьютер"] = "computer"
//dict["компьютер"] = "mac"
//
//dict.updateValue("mac1", forKey: "компьютер")
//
//let computer = dict["компьютер"]
//
//if let comp = dict["комп"] {
//    print(comp)
//} else {
//    print("no value for your key")
//}
//
//dict.removeValue(forKey: "компьютер")
//
//dict = [:] // method for clearing dictionary
//
//dict["hello"] = "world"
//
//
//for (key, val) in dict {
//    print("key = \(key)", "value = \(val)")
//}


var students: [String: Int] = [
    "Иван Петров": 5,
    "Мария Смирнова": 4,
    "Алексей Кузнецов": 3,
    "Екатерина Орлова": 5,
    "Дмитрий Павлов": 2,
    "Ольга Никитина": 4,
    "Сергей Волков": 3,
    "Анастасия Федорова": 5,
    "Михаил Егоров": 2,
    "Татьяна Соколова": 4,
    "Андрей Морозов": 5,
    "Ксения Попова": 3,
    "Никита Захаров": 4
]

students["Дмитрий Павлов"] = 4
students["Михаил Егоров"] = 5

students.removeValue(forKey: "Алексей Кузнецов")

for (key, val) in students {
    print("имя студента = \(key)" + ",", "оценка за экзамен = \(val)")
}

let months: [(name: String, days: Int)] = [
    ("January", 31),
    ("February", 28),
    ("March", 31),
    ("April", 30),
    ("May", 31),
    ("June", 30),
    ("July", 31),
    ("August", 31),
    ("September", 30),
    ("October", 31),
    ("November", 30),
    ("December", 31)
]

for month in months {
    print("\(month.name), \(month.days)")
}

let months1: [String: Int] = [
    "January": 31,
    "February": 28, // 29 в високосном году
    "March": 31,
    "April": 30,
    "May": 31,
    "June": 30,
    "July": 31,
    "August": 31,
    "September": 30,
    "October": 31,
    "November": 30,
    "December": 31
]

for (key, val) in months1 {
    print("месяц = \(key)" + ",", "кол-во дней = \(val)")
}

let letterArray = ["a", "b", "c", "d", "e", "f", "g", "h"]
let numberArray = ["1", "2", "3", "4", "5", "6", "7", "8"]
var dictionaryChess : [String:Bool] = [:]


for letterIndex in 0..<letterArray.count {
    for numberIndex in 0..<numberArray.count {
        dictionaryChess[letterArray[letterIndex] + numberArray[numberIndex]] = (letterIndex % 2 != numberIndex % 2)
    }
}

for (key, value) in dictionaryChess {
    print("\(key) is \(value)")
}

