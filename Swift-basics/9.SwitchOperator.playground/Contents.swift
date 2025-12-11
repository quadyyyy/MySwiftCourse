// label usage example
//loop: for _ in 0...100000 {
//    for l in 0..<10 {
//        if l == 5 {
//            break loop
//        }
//        print(l)
//    }
//}


var age = 21
var name = "Timofey"

switch age {
case 7...18: print("schooler")
case 19...25: print("young adult")
case 25...55: break
default: print("skibidi")
}

let tuple = (name, age)
switch tuple {
case ("Timofey", 21): print("hi")
default: print("I don't know you")
}

var point = (5, -5)

switch point {
case let (x, y) where x == y:
    print("diagonal")
default:
    print("not diagonal")
}


// homework

// task 1

let string = "aBdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYz"
let vowels = "aeiouAEIOU"
let consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"

var glas_cnt = 0
var sogl_cnt = 0

for char in string {
    switch char {
    case let c where vowels.contains(c): glas_cnt += 1
    case let c where consonants.contains(c): sogl_cnt += 1
    default: break
    }
}
print(glas_cnt, sogl_cnt)


// task 2

var age1 = 31

switch age1 {
case 0...6: print("baby, childhood")
case 7...18: print("schooler, school")
case 18...22: print("student, university")
case 22...65: print("worker, job")
case 65... : print("eldership")
default: break
}

// task 4 - позже
