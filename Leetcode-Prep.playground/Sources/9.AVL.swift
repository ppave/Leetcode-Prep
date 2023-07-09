import Foundation

// First self-balancing BST

class AVLNode<T> {
    var value: T
    var leftChild: AVLNode?
    var rightChild: AVLNode?
    var height = 0
    
    public var balanceFactor: Int {
        leftHeight - rightHeight
    }
    
    var leftHeight: Int {
        leftChild?.height ?? -1
    }
    
    var rightHeight: Int {
        rightChild?.height ?? -1
    }
    
    init(value: T) {
        self.value = value
    }
}

class AVLTree<T: Comparable> {
    var root: AVLNode<T>?
}
