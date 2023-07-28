import Foundation

// https://github.com/ppave/AlgorithmExperiments/blob/master/Sources/DataStructuresAlgorithms/Algorithms/SortingAlgorithms.swift
// https://www.bigocheatsheet.com

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

// Merge Sort (split & merge) Θ(n log n)
func mergeSort<Element: Comparable>(_ array: [Element]) -> [Element] {
    guard array.count > 1 else {
        return array
    }
    let middle = array.count / 2
    let left = mergeSort(Array(array[..<middle]))
    let right = mergeSort(Array(array[middle...]))
    return merge(left, right)
}

// Take two sorted arrays and combine them while retaining the sort order.
func merge<Element: Comparable>(_ left: [Element], _ right: [Element]) -> [Element] {
    var leftIndex = 0, rightIndex = 0
    var result: [Element] = []
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        if leftElement < rightElement {
            result.append(leftElement)
            leftIndex += 1
        } else if rightElement < leftElement {
            result.append(rightElement)
            rightIndex += 1
        } else {
            result.append(leftElement)
            leftIndex += 1
            result.append(rightElement)
            rightIndex += 1
        }
    }
    if leftIndex < left.count {
        result.append(contentsOf: left[leftIndex...])
    }
    if rightIndex < right.count {
        result.append(contentsOf: right[rightIndex...])
    }
    return result
}

//Heap Sort O(n log n)
extension Heap {
    public mutating func sort() -> [Element] {
        for index in elements.indices.reversed() {
            elements.swapAt(0, index)
            siftDown(from: 0, upTo: index)
        }
        return elements
    }
}

// Quick Sort O(n log n)
// One important feature of Quicksort is choosing a pivot point.
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { return a }
  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }
  return quicksort(less) + equal + quicksort(greater)
}
