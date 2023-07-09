import Foundation

struct Stack<Element> {
    var storage: [Element] = []
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    mutating func pop(_ element: Element) -> Element? {
        storage.popLast()
    }
    
    func peek() -> Element? {
        storage.last
    }
    
    var isEmpty: Bool {
        peek() == nil
    }
}
