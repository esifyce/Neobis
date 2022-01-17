import Foundation

// MARK: - Your task is to find the first element of an array that is not consecutive.

// a function that accepts an array that returns a non-consecutive number
func firstNonConsecutive (_ arr: [Int]) -> Int? {
    
    var i = 1
    // passing through the array excluding index
    for _ in arr {
        // check consecutive number
        if i < arr.count && arr[i] - arr[i - 1] != 1 {
            // to get result
            return arr[i]
        }
        // increment value
        i += 1
    }
    // if arr isEmpty, we return nil
    return nil
}
// print result in console, else 0
print(firstNonConsecutive([1,2,3,4,6,7,8]) ?? 0)

