import Foundation

// MARK: - We need a method in the List Class that may count specific digits from a given list of integers. This marked digits will be given in a second list. The method .count_spec_digits()/.countSpecDigits() will accept two arguments, a list of an uncertain amount of integers integers_lists/integersLists (and of an uncertain amount of digits, too) and a second list, digits_list/digitsList that has the specific digits to count which length cannot be be longer than 10 (It's obvious, we've got ten digits). The method will output a list of tuples, each tuple having two elements, the first one will be a digit to count, and second one, its corresponding total frequency in all the integers of the first list. This list of tuples should be ordered with the same order that the digits have in digitsList

class Arrays {
    // func received two array and return array without duplicate in both
    func remove(firstArr: [Int], secondArr: [Int]) -> [(Int, Int)] {
        
        // create Set in array by conditions
        var stuff:[(Int, Int)] = []
        // for further sort through
        var number = ""
        
        // loop for merge array in string
        for i in firstArr {
            number += "\(i)"
        }
        // relize separate string in Int and discatding symbyls by "-"
        let separateNumber = number.compactMap{ Int(String($0)) }
        
        // we find same number
        let arrayResult = separateNumber.filter { secondArr.contains($0) }
        // We add up in order to show the amount of the discarded number
        let arrTotal = arrayResult + secondArr
        
        // use discarding same number
        for i in Set(arrTotal) {
            // search count same number
            let resultCount = arrayResult.filter { $0 == i}.count
            // add array value an count number from the array
            stuff.append((i, resultCount))
        }
        // return result set in array by conditions
        return stuff
    }
}

// implement class
var totalArr = Arrays()

// show results on console
print(totalArr.remove(firstArr: [1, 1, 2 ,3 ,1 ,2 ,3 ,4],
                      secondArr: [1, 3]))
print(totalArr.remove(firstArr: [-18, -31, 81, -19, 111, -888],
                      secondArr: [1, 8, 4]))
print(totalArr.remove(firstArr: [-77, -65, 56, -79, 6666, 222],
                      secondArr: [1, 8, 4]))
