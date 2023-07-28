import Foundation

// https://github.com/ppave/AlgorithmExperiments/blob/master/Sources/DataStructuresAlgorithms/Algorithms/SortingAlgorithms.swift

// The Swift Standard Library sort algorithm uses a hybrid of sorting approaches
// with insertion sort being used for small (<20 element) unsorted partitions.
// In practice, a lot of data collections will already be largely — if not entirely — sorted,
// and insertion sort will perform quite well in those scenarios.



// Insertion Sort O(n2)
// One of the fastest sorting algorithm, if the data is already sorted - O(n)
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

// Quick Sort O(n log n)
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { return a }

  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }

  return quicksort(less) + equal + quicksort(greater)
}
