import UIKit

let numbers = [1,2,3,4,5,6,7,8,9]
// 1..<5 等价于 Range(start: 1, end: 5)
numbers[1..<5] // [2,3,4,5]

extension Range where Element : Comparable {
    func contains(element: Element) -> Bool {
        return element >= startIndex && element < endIndex
    }
}

(Int.min..<0).contains(-1) // true
(Int.min..<0).contains(0) // false
(Int.min..<0).contains(1) // false

Int.min..<0 ~= -1 // true
Int.min..<0 ~= 0 // false
Int.min..<0 ~= 1 // false
