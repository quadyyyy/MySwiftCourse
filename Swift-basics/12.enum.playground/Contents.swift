enum Direction : String {
    case Left = "Left!"
    case Right = "Right!"
}


enum Action {
    case walk(meters: Int)
    case run(meters: Int, speed: Int)
    case stop
    case turn(direction: Direction)
}


var action = Action.run(meters: 20, speed: 15)
action = .stop
action = .walk(meters: 10)

var dir = Direction(rawValue: "Left!")!
action = .turn(direction: dir)

switch action {
case .stop:
    print("Stop")
case .walk(let meters) where meters <= 100:
    print("short walk")
case .walk(let meters) where meters > 100:
    print("long walk")
case .turn(let dir) where dir == .Left:
    print("Turn Left")
case .turn(let dir) where dir == .Right:
    print("Turn Right")
default: break
}



// task 1

//enum chess {
//    case Pawn(color: String, row: String, column: Int)
//    case King(color: String, row: String, column: Int)
//    case Queen(color: String, row: String, column: Int)
//    case Bishop(color: String, row: String, column: Int)
//    case Knight(color: String, row: String, column: Int)
//    case Rook(color: String, row: String, column: Int)
//}
//
//var whiteKing = chess.King(color: "white", row: "e", column: 5)
//var whiteQueen = chess.Queen(color: "white", row: "e", column: 7)
//var blackKing = chess.King(color: "black", row: "g", column: 8)


//task 2

enum Chess : String {
    case Pawn = "Pawn"
    case King = "King"
    case Queen = "Queen"
    case Bishop = "Bishop"
    case Knight = "Knight"
    case Rook = "Rook"
}

let figures = [Chess.Pawn, Chess.King, Chess.Queen, Chess.Bishop, Chess.Knight, Chess.Rook]

func chessVars(figures: [String]) -> Void {
    let chessFigures: [String:(color: String, row: String, column: Int)] = [
        "Pawn": ("White", "a", 5),
        "King": ("White", "g", 7),
        "Queen": ("White", "h", 3),
        "Bishop": ("White", "e", 1),
        "Knight": ("White", "b", 5),
        "Rook": ("White", "d", 8)
    ]

    for figure in figures {
        if let info = chessFigures[figure] {
            print("\(info.color) \(figure) is on \(info.row)\(info.column)")
        } else {
            print("\(figure) not found")
        }
    }
}

