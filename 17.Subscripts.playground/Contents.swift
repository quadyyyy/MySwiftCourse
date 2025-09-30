let array = ["a", "b", "c"]

struct Family {
    var father = "Father"
    var mother = "Mother"
    var kids = ["Kid1", "Kid2", "Kid3"]
    
    var count : Int {
        return 2 + kids.count
    }
    
    subscript(index: Int) -> String? {
        get {
            switch(index) {
            case 0: return father
            case 1: return mother
            case 2..<(2+kids.count): return kids[index-2]
            default: return nil
            }
        }
        set {
            
            let value = newValue ?? ""
            
            switch(index) {
            case 0: return father = value
            case 1: return mother = value
            case 2..<(2+kids.count): kids[index-2] = value
            default: break
            }
        }
    }
    subscript(index: Int, suffix: String) -> String? {
        var name = self[index] ?? ""
        name += " " + suffix
        return name
    }
}

print(Family()[0]!)


struct Field {
    
    var dict = [String: String]()
    
    func key(column: String, row: Int) -> String {
        return column + String(row)
    }
    
    
    subscript(column: String, row: Int) -> String? {
        get {
            return dict[key(column: column, row: row)]
        }
        set {
            dict[column + String(row)] = newValue
        }
    }
}


// homework

struct ChessBoard {
    
    enum Color {
        case White
        case Black
    }
    
    let columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    
    subscript(column: String, row: Int) -> Color? {
        get {
            if columns.contains(column) && row >= 1 && row <= 8 {
                if let columnIndex = columns.firstIndex(of: column.lowercased()) {
                    return(columnIndex + row) % 2 == 0 ? Color.White : Color.Black
                }
            }
            return nil
        }
    }
}

