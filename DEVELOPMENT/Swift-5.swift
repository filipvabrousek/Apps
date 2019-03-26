//import UIKit

print("Hello Swift 5 !!!")

// 1 ------------------------------------------ isMultiple of
8.isMultiple(of: 2)

// 2 ------------------------------------------ RAW Strings
let raw = #"Filip is a "coder.""#


// 3 ------------------------------------------ Handling future ennum cases (@unknown)
enum E {
    case short
    case obvious
    case insecure
}

func show(err: E){
    switch err {
    case .short:
        print("Password is short")
        
    case .obvious:
        print("Pssword obvious.")
        
    @unknown default:
        print("Not suitable.")
    }
}


show(err: .insecure) // not suitable (case not handled)

print("HO")


// 4 ------------------------------------------ Getting values from dictionary
let times = [
    "Filip": "19",
    "Martin": "21"
]

let f = times.compactMapValues {Int($0)}
print(f)


// Custom String Interpolation
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: String){
        appendLiteral("\(2 * Int(value)!)")
    }
}


var e = 24
print("I am \(String(e))")



// Result
enum N:Error {
    case noconnection
    case nodata
}

func fetch(url: String, completion: @escaping(Result<Int, N>) -> Void) {
    if url.isEmpty {
        completion(.failure(.nodata))
    } else {
        completion(.success(1))
    }
}


fetch(url: "s") { (res) in
    
    switch res {
    case .success(let count):
        print("Count")
        
    case .failure(let err):
        print("Error")
        
    }
}





// Dynamically callable types

/*
 @dynamicCallable func area(a: Int) -> Int {
 return a * a
 }
 
 let res = area.dynamicallyCall(withKeywordArguments: ["a": 3])
 print(res)
 */








// Swift 4.2 addition
var s = [3, 4, 8]
s.allSatisfy {$0 > 2}
s.shuffle()
s.shuffled()
s.randomElement()

var els = ["Filip", "Martin"]
els.removeAll(where: {$0.hasPrefix("M")}) // Just "Filip", sorry Martin

