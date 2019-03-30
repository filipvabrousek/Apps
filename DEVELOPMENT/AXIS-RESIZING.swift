func era(h: Double, curr: Double, max: Double, min: Double) -> Double {
    var diff = max - min
    var w = (curr - min) * (h / diff)
    return w
}

var res = era(h: 200, curr: 162.5, max: 130, min: 195)
print("Res \(res)")
