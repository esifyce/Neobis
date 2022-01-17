import Foundation

// MARK: - Define a method/function that removes from a given array of integers all the values contained in a second array.

class Array {
    // func received two array and return array without duplicate in both
    func remove(firstArr: [Int], secondArr: [Int]) -> [Int] {
        // use filter which use iteration by first array in search no contain number in second array
        let arrayResult = firstArr.filter { !secondArr.contains($0)
        }
        // total result in [Int] format
        return arrayResult
    }
}

// implement class
var totalArr = Array()

// show results on console
print(totalArr.remove(firstArr: [1, 1, 2 ,3 ,1 ,2 ,3 ,4],
                      secondArr: [1, 3]))
print(totalArr.remove(firstArr: [1, 1, 2 ,3 ,1 ,2 ,3 ,4, 4, 3 ,5, 6, 7, 2, 8],
                      secondArr: [1, 3, 4, 2]))
print(totalArr.remove(firstArr: [8, 2, 7, 2, 3, 4, 6, 5, 4, 4, 1, 2 , 3],
                      secondArr: [2, 4, 3]))
