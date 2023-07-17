import Foundation

class Node<Value> {
    var value: Value
    var next: Node?
    weak var previous: Node?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
    }
}

class LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    var isEmpty: Bool {
        head == nil
    }
    
    func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil, currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    @discardableResult
    func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard node !== tail else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    func removeLast() -> Value? {
        var prev = head
        var current = head
        while let next = current?.next {
            prev = current
            current = next
        }
        prev?.next = nil
        tail = prev
        return current?.value
    }
    
    func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    func copyNodes() {
        guard var oldNode = head else { return }
        head = Node(value: oldNode.value)
        var current = head
        while let next = oldNode.next {
            oldNode = next
            current?.next = Node(value: next.value)
            current = current?.next
        }
        tail = current
    }
}

class DoublyLinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool {
        head == nil
    }
    
    var first: Node<T>? {
        head
    }
    
    var last: Node<T>? {
        tail
    }
    
    func prepend(_ value: T) {
        let newNode = Node(value: value)
        guard let headNode = head else {
            head = newNode
            tail = newNode
            return
        }
        newNode.previous = nil
        newNode.next = headNode
        headNode.previous = newNode
        head = newNode
    }
    
    func append(_ value: T) {
        let newNode = Node(value: value)
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        newNode.previous = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    func remove(_ node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        if next == nil {
            tail = prev
        }
        node.previous = nil
        node.next = nil
        return node.value
    }
}
