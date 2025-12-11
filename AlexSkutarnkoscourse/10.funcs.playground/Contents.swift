func calculateMoney(InWallet wallet: [Int], type: Int? = nil) -> (Int, Int) {
    var sum = 0
    var count = 0
    
    for value in wallet {
        
        if value == (type ?? value) {
            sum += value
            count += 1
        }
    }
    
    return (sum, count)
}

let wallet = [100, 10, 20,5,7,1,8,3,8,4,9]
print(calculateMoney(InWallet: wallet))

func calculateMoney(inRange range: Int...) -> Int {
    var sum = 0
    for value in range {
        sum += value
    }
    return sum
}


// homework

// task 1

func heartEmojii() -> String {
    return "❤️"
}

func smileFace() -> String {
    return "😊"
}

func honeyEmojii() -> String {
    return "🍯"
}

print(heartEmojii(), smileFace(), honeyEmojii())

// task 2

// логика в том, чтобы искать индекс заданного row в массиве rows и работать уже с индексами
func chessCellColor(row: String, column: Int) -> String {
    let rows = ["a", "b", "c", "d", "e", "f", "g", "h"]
    
    if let rowIndex = rows.firstIndex(of: row.lowercased()) {
        return (rowIndex + column) % 2 == 0 ? "White" : "Black"
    } else {
        return "Invalid"
    }
}

print(chessCellColor(row: "a", column: 2))

// task 3

func reversedArray(sequence: Int...) -> Array<Any> {
    var array: [Int] = []
    array.append(contentsOf: sequence)
    
    return array.reversed()
}

print(reversedArray(sequence: 1, 2,3,4,5,6,7,8,9,0))

// task 4

func reversedArray1(seq: inout [Int]) {
    seq.reverse()
}

var numbers = [1, 32, 321, 3, 4, 5, 6]
reversedArray1(seq: &numbers)
print(numbers)

// task 5
// на вход строка, все гласные переводятся uppercase, согласные в lowercase, цифры заменяются на слова, к примеру 1 = one, знаки препинания заменяются на пробел

func task5(string: String) -> String {
    let vowels = "aeiouAEIOU"
    let consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
    let numbers: [Int:String] = [
        1: "one",
        2: "two",
        3: "three",
        4: "four",
        5: "five",
        6: "six",
        7: "seven",
        8: "eight",
        9: "nine",
        0: "zero"
    ]
    
    var result = ""
    
    for char in string {
        switch char {
        case let c where vowels.contains(c): result.append(c.uppercased())
        case let c where consonants.contains(c): result.append(c.lowercased())
        case let c where c.isNumber:
            if let digit = c.wholeNumberValue, let word = numbers[digit] {
                result.append(word)
            }
        default: result.append(" ")
        }
    }
    
    return result
}


print(task5(string: "hello world, 1!2,3 oh how s1k#b1t"))
