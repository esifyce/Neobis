import Foundation

// MARK: - You are given a function that should insert an asterisk (*) between every pair of even digits in the given input, and return it as a string. If the input is a sequence, concat the elements first as a string.

// for check and insert between even values
func insertBetweenEven(array: [String]) -> String {
    // variable for check previous even number
    var ctr = 0
    // return values this func, which save values passing througn iterating
    var temp = ""
    
    // use count element array for iteration
    for i in 0...array.count - 1 {
        // check first[0] element and element on the right[0+1]
        if Int(array[i])! % 2 == 0 && ctr == 1 {
            // append array * between even numbers
            temp += "*" + array[i]
            // check first[0] element on even
        } else if Int(array[i])! % 2 == 0 {
            // Since the first element even, that we check previous element in next iteration
            ctr += 1
            // appand in array
            temp += array[i]
            // else odd element appending in array
        } else {
            temp += array[i]
            // reset check on previous element on even
            ctr = 0
        }
    }
    // we get a ready array
    return temp
}
// for possible input of different types of values
func checkType (obj : Any) -> String {
    
    if obj is Int {
        // return String type
        let temp = "\(obj)"
        
        return toGetResultArr(temp: temp)
    }
    else if obj is String {
        // return String type
        let temp = "\(obj)"
        
        return toGetResultArr(temp: temp)
    }
    else if obj is [Int]  {
        // convert array in type [String.Element]
        let temp = (obj as! [Int]).flatMap({String($0)})
        // return String type
        let string = "\(temp)"
        
        return toGetResultArr(temp: string)
    }
    else if obj is [String] {
        // convert array in type [String.Element]
        let temp = (obj as! [String]).flatMap({String($0)})
        // return String type
        let string = "\(temp)"
        
        return toGetResultArr(temp: string)
    }
    else {
        // if none-values return empty array
        return toGetResultArr(temp: "")
    }
}
// for input and output data
func toGetResultArr(temp: String) -> String {
    // array for write and read values
    var resultType = [String]()
    // loop for iteration to the checkType values
    for v in temp {
        // if received data array, which we miss
        if v == "[" || v == "\"" || v == "," ||
            v == " " || v == "]" {
            continue
        }
        // append in array for future check between even
        resultType.append(String(v))
    }
    // between even number insert *
    return insertBetweenEven(array: resultType)
}
// show results on console
print("5312708 --> \(checkType(obj: 5312708))")
print("\"0000\" --> \(checkType(obj: "0000"))")
print("[1, 4, 64] --> \(checkType(obj: [1, 4, 64]))")
