import UIKit


class User {
    var name: String
    var stime: Int
    var rtime: Int
    var order: Int
    
    init(name: String, stime: Int, rtime: Int, order: Int) {
        self.name = name
        self.stime = stime
        self.rtime = rtime
        self.order = order
    }
}


func proximity(myswim: Int, myrun: Int, hisswim: Int, hisrun:Int) -> Int {
    
    let sp = Double(myswim) / Double(hisswim) // Double ????
    let spof = abs(sp - 1) * 100
    
    let rp = Double(myrun) / Double(hisrun)
    let rdof = abs(rp - 1) * 100
    
    let diff = (spof + rdof) // round
    // print("RP \(rp)  SP \(sp)")
    print("Diff")
    return Int(diff)
}



var users = [User]()

func fetch(st:Int, rt:Int){
    var email = "petr@a.com" // comes from Firebase
    var hst = 200
    var hrt = 600
    
    var porder = proximity(myswim: st, myrun: rt, hisswim: hst, hisrun: hrt)
    
    let petr = User(name: email, stime: st, rtime: rt, order: porder)
    users.append(petr)
    print("Petr \(porder)")
    
    var vemail = "vera@a.com" // comes from Firebase
    var vhst = 300
    var vhrt = 900
    
    var fordera = proximity(myswim: st, myrun: rt, hisswim: vhst, hisrun: vhrt)
    
    let vera = User(name: vemail, stime: st, rtime: rt, order: fordera)
    users.append(vera)
    
    users = users.sorted(by: {$0.order < $1.order})
    
    print("Vera \(fordera)")
    
}




fetch(st: 200, rt: 1300) // my time


for user in users {
    print("U \(user.name) proximity \(user.order)")
}


