import Foundation

class HashTable<Key: Hashable, Value> {
    private typealias Element  = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    private var count = 0
    
    var isEmpty: Bool { return buckets.count == 0 }
    
    // TODO resize hash table based on load factor
    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }
    
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    /*
     hashTable["firstName"] = "Steve"   // insert
     let x = hashTable["firstName"]     // lookup
     hashTable["firstName"] = "Tim"     // update
     hashTable["firstName"] = nil       // delete
     */
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    func value(forKey key: Key) -> Value? {
        let index  = self.index(forKey: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    
    @discardableResult
    func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index  = self.index(forKey: key)
        //update
        for (i, element) in buckets[index].enumerated() {
            if element.key  == key {
                buckets[index][i].value = value
                return element.value
            }
        }
        //add new
        buckets[index].append((key: key, value: value))
        return nil
    }
    
    @discardableResult
    func removeValue(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                return element.value
            }
        }
        return nil
    }
}
