import Foundation

struct RingBuffer<T> {
    var array: [T?]
    var readIndex = 0
    var writeIndex = 0
    
    init(count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    var first: T? {
        array[readIndex]
    }
    
    mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    var availableSpaceForReading: Int {
        writeIndex - readIndex
    }
    
    var availableSpaceForWriting: Int {
        array.count - availableSpaceForReading
    }
    
    var isEmpty: Bool {
        availableSpaceForReading == 0
    }
    
    var isFull: Bool {
        availableSpaceForWriting == 0
    }
}
