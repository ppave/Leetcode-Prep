import Foundation

// https://github.com/ppave/AlgorithmExperiments/blob/master/Sources/DataStructuresAlgorithms/Algorithms/SearchingAlgorithms.swift

// Binary search is one of the most efficient searching algorithms with a time complexity of O(log n).
// This is comparable with searching for an element inside a balanced binary search tree.

// Whenever you read something along the lines of “Given a sorted array...”,
// consider using the binary search algorithm.

// Also, if you are given a problem that looks like it is going to be O(n2) to search,
// consider doing some up-front sorting
// so you can use binary searching to reduce it down to the cost of the sort at O(n log n).




//Linear Search, O(n)
func linearSearch<T: Equatable>(_ array: [T], _ value: T) -> Int? {
    for (index, object) in array.enumerated() where object == value {
        return index
    }
    return nil
}

// O(log n), requires the array to be sorted & to support RandomAccessCollection
extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        let range = range ?? startIndex..<endIndex
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: middle..<range.upperBound)
        }
    }
}

func exampleBinarySearch() {
    let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]
    
    let search31 = array.firstIndex(of: 31)
    let binarySearch31 = array.binarySearch(for: 31)
    
    print("firstIndex(of:): \(String(describing: search31))")
    print("binarySearch(for:): \(String(describing: binarySearch31))")
}
