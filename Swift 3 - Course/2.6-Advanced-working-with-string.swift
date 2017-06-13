var str = "Hello"

var new = str + " Filip!"


// n (newTypeString)
let n = NSString(string: new)

n.substring(to: 5)

n.substring(from: 5)


NSString(string: n.substring(from: 5)).substring(to: 6)

n.substring(with: NSRange(location: 5, length: 6))


if n.contains("Filip"){
print("newTypeStr contains Filip")
}



n.components(separatedBy: " ")

n.uppercased
n.lowercased

