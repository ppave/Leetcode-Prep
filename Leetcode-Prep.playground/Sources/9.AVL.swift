import Foundation

// First self-balancing BST

class AVLNode<T> {
    var value: T
    var leftChild: AVLNode?
    var rightChild: AVLNode?
    var height = 0
    
    var balanceFactor: Int {
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
    
    func insert(_ value: T) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<T>?, value: T) -> AVLNode<T> {
        guard let node else {
            return AVLNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

extension AVLTree {
    private func leftRotate(_ node: AVLNode<T>) -> AVLNode<T> {
        let pivot = node.rightChild!
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<T>) -> AVLNode<T> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<T>) -> AVLNode<T> {
        guard let rightChild = node.rightChild else {
            return node
        }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<T>) -> AVLNode<T> {
        guard let leftChild = node.leftChild else {
            return node
        }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
    private func balanced(_ node: AVLNode<T>) -> AVLNode<T> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
}
