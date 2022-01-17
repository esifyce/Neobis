import Foundation

// MARK: - Your task is to remove all consecutive duplicate words from a string, leaving only first words entries. For example: "alpha beta beta gamma gamma gamma delta alpha beta beta gamma gamma gamma delta" --> "alpha beta gamma delta alpha beta gamma delta"

// array by assignment
var arrInput = ["alpha beta beta gamma gamma gamma delta alpha beta beta gamma gamma gamma delta"]

// array by result
var arrOutput = [String]()

// itterating array for separate and
for (index, value) in arrInput.enumerated() {
    // separate array by index
    for i in arrInput[index].components(separatedBy: " ") {
        // check on consecutive duplicate words
        if i != arrOutput.last {
            // adding in our temporary array
            arrOutput.append(i)
        }
    }
    // show in console initial value --> results words without dublicate
    print("\(value) --> \(arrOutput.joined(separator: " "))")
}

