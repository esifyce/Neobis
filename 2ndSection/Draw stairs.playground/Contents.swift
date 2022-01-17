import Foundation

// MARK: - Given a number n, draw stairs using the letter "I", n tall and n wide, with the tallest in the top left.

// function relizizing display half I pyramyd
func drawStairs(count: Int) -> String {
    var i = ""
    var temp = 0
    // use range so as to understand numbers of iteration
    for _ in 0 ... count - 1 {
        // start letters
        i += "I\n"
        // range without index
        for _ in 0...temp {
            // create space in relation to range
            i += " "
        }
        // increasing space between I
        temp += 1
    }
    // return string results
    return i
}

// show result stairs in console
print(drawStairs(count: 8))
