import Foundation

// A binary search tree (or BST) is a data structure that facilitates fast lookup, addition, and removal operations.
// Each operation has an average time complexity of O(log n).

// A binary search tree achieves this performance by imposing two rules on the binary tree
// - The value of a left child must be less than the value of its parent.
// - The value of a right child must be greater than or equal to the value of its parent.

class BinaryNode<T> {
    var value: T
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    
    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {
    var root: BinaryNode<T>?
}

extension BinarySearchTree {
    func insert(_ value: T) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryNode<T>?, value: T) -> BinaryNode<T> {
        guard let node else {
            return BinaryNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
}

extension BinarySearchTree {
    func contains(_ value: T) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

extension BinaryNode {
    var min: BinaryNode {
        return leftChild?.min ?? self
    }
}

extension BinarySearchTree {
    func remove(_ value: T) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<T>?, value: T) -> BinaryNode<T>? {
        guard let node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
}
