import Foundation

class BinaryTree<T> {
    var value: T
    var leftChild: BinaryTree?
    var rightChild: BinaryTree?
    
    init(value: T) {
        self.value = value
    }
}

extension BinaryTree {
    // https://www.javatpoint.com/inorder-traversal
    func traverseInOrder(visit: (T) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    // https://www.javatpoint.com/preorder-traversal
    func traversePreOrder(visit: (T) -> Void) {
        visit(value)
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    // https://www.javatpoint.com/postorder-traversal
    func traversePostOrder(visit: (T) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
        visit(value)
    }
}
