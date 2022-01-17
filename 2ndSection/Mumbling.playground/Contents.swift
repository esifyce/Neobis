import Foundation

// MARK: - This time no story, no theory. The examples below show you how to write function accum: The parameter of accum is a string which includes only letters from a..z and A..Z.

// func for getting from the word sequence
func accum(_ s: String) -> String {
    // variable for return data in func and finding by iteration
    var result = ""
    
    // iterating string for separation on index and value
    for (index, value) in s.enumerated() {
        
        // first letter by condition
        result += value.uppercased()
        // create continue sequence
        for _ in 0..<index {
            // continued after capital letter
            result += value.lowercased()
        }
        // determining the end of a letter
        if index < s.count - 1 {
            // we use separation by - because of condition
            result += "*"
        }
    }
    // result string after itteration with addition
    return result
}

// show results on console
print("abcd --> \(accum("abcd"))")
print("RqaEzty --> \(accum("RqaEzty"))")
print("cwAt --> \(accum("cwAt"))")
