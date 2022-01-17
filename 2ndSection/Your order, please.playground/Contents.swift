import Foundation

// MARK: - Your task is to sort a given string. Each word in the string will contain a single number. This number is the position the word should have in the result.

//  sort a given string this number is the position the word
func arrSortedBy(array: [String]) -> [String] {
    
    // create temporary array for return results
    var temp = [String]()
    
    // sorting with ascending number search
    temp = array.sorted { $0.filter { "0" <= $0 && $0 <= "9" } <                        $1.filter { "0" <= $0 && $0 <= "9" } }
    return temp
}

// array by assignment
var arrWithInfo = ["is2 Thi1s T4est 3a",
                   "4of Fo1r pe6ople g3ood th5e the2",
                   ""]
// array for write separate string in words
var arrSeparateOnWord = [String]()

// iterating array for separate and sort an array
for (index, value) in arrWithInfo.enumerated() {
    // separate array by index
    for i in arrWithInfo[index].components(separatedBy: " ") {
        // adding in our temporary array
        arrSeparateOnWord.append(i)
    }
    
    // use our function for sort
    let resultSorted = arrSortedBy(array: arrSeparateOnWord)
    
    // Show result with to get function with used separator for remove the array
    print("\(value) -> \(resultSorted.joined(separator: " "))")
    // clear temporary array for new string
    arrSeparateOnWord = []
}
