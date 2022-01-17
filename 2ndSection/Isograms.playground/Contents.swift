import Foundation

// MARK: - An isogram is a word that has no repeating letters, consecutive or non-consecutive. Implement a function that determines whether a string that contains only letters is an isogram. Assume the empty string is an isogram. Ignore letter case.

// function for check unique char in words
func isIsogram(_ string: String) -> Bool {
    // array need for remove the register and check comparisons Set & Arr
    var array: [Character] = []
    // we can igonore letter case
    for n in string.lowercased() {
        array.append(n)
    }
    // if string count equal unique letters that is isogram
    if array.count != Set(array).count {
        return false
    }
    return true
}

// Input words for check on isogram
print("Dermatoglyphics --> \(isIsogram("Dermatoglyphics"))")
print("aba --> \(isIsogram("aba"))")
print("moOse --> \(isIsogram("moOse"))")
