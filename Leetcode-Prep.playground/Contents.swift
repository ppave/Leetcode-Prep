import Foundation

func insertionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    for i in 1..<array.count {
        for j in (1...i).reversed() {
            if array[j] < array[j - 1] {
                array.swapAt(j, j - 1)
            } else {
                break
            }
        }
    }
}

func exampleInsertionSort() {
    var array = [9, 4, 10, 3]
    print("Original: \(array)")
    insertionSort(&array)
    print("Insertion sorted: \(array)")
}

exampleInsertionSort()
