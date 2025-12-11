let numbers = [1,4,72,78,3,7,3,2,7, 23,123,2,3,5,3]

func filterArray(array: [Int], f: (Int) -> Bool) -> [Int] {
    
    var filtered = [Int]()
    for i in array {
        if f(i) {
            filtered.append(i)
        }
    }
    return filtered
}

//func compare(i: Int) -> Bool {
//    return i % 2 == 0
//}


// пример клоужера
print(filterArray(array: numbers, f: {(i: Int) -> Bool in
    return i % 2 == 0
}))

// сокращенные формы $0 - нулевой аргумент, $1 - первый
filterArray(array: numbers, f: {i in i % 2 == 1})
filterArray(array: numbers, f: {$0 % 3 == 0})

// trailing closure
filterArray(array: numbers) {$0 % 3 == 0}



// closure может хавать штуки вне функции, к примеру
let array = [1,2,3,5,4,7,1,8]

filterArray(array: numbers) { value in
    
    for include in array { // array - внешний массив, но все еще его можно брать
        if include == value {
            return true
        }
    }
    return false
}



var dict = [Int:Bool]()
for value in array {
    dict[value] = true
    
}

filterArray(array: numbers) { value in
        return dict[value] != nil
}


// homework

// task 1
func printNumbersAndDoSomething(action: () -> Void) {
    for i in 1...10 {
        print(i)
    }
    action()
}

printNumbersAndDoSomething {
    print("Closure вызван")
}

// task 2

let array1 = [1,123,4,7,2,7,5,8,3,2,9,6]

let ascending = array1.sorted { (a, b) -> Bool in
    return a < b
}

let descending = array1.sorted { (a, b) -> Bool in
    return a > b
}

print(ascending)
print(descending)

// task 3

func task3(array: [Int], f: (Int, Int?) -> Bool) -> Int {
    var ebam: Int? = nil
    
    for char in array {
        if f(char, ebam) == true {
            ebam = char
        }
    }
    return ebam!
}

let maxvalue = task3(array: [1,3,53,7,4,8,5,3]) { current, max in
    return max == nil || current > max!
}
print(maxvalue)

let minvalue = task3(array: [1,3,53,7,4,8,5,3]) { current, min in
    return min == nil || current < min!
}
print(minvalue)

// task 4

let someString = "ejkhrkqwjneqkwjebk124jbk143654,3234jlk32klk"
let stringArray = Array(someString)

func priority(char: Character) -> Int {
    
    let consonants = "bcdfghjklmnpqrstvwxyz"
    let vowels = "aeiouAEIOU"
    
    switch String(char.lowercased()) {
    case let c where vowels.contains(c):
        return 0
    case let c where consonants.contains(c):
        return 1
    case let c where "0123456789".contains(c):
        return 2
    default: return 3
    }
}

let sortedArray = stringArray.sorted { (a, b) -> Bool in
    let rankA = priority(char: a)
    let rankB = priority(char: b)
    
    if rankA == rankB {
        return a < b
    } else {
        return rankA < rankB
    }
}
print(sortedArray)


// task 5

func task5(array: [Character], f: (Character, Character?) -> Bool) -> Character {
    var ebam: Character? = nil
    
    for char in array {
        if f(char, ebam) == true {
            ebam = char
        }
    }
    return ebam!
}

let letters: [Character] = Array("asdkljaldkjakldjnadlkjadklajsdjklasdajkls")

let maxValue2 = task5(array: letters) { current, max in
    return max == nil || current > max!
}
print(maxValue2)
