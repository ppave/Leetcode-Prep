import Foundation

class TrieNode<T: Hashable> {
    var value: T?
    weak var parent: TrieNode?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    
    init(value: T?, parent: TrieNode?) {
        self.value = value
        self.parent = parent
    }
}

class Trie<T: Collection> where T.Element: Hashable {
    typealias Node = TrieNode<T.Element>
    let root = Node(value: nil, parent: nil)
    
    func insert(_ collection: T) {
        var current = root
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(value: element, parent: current)
            }
            current = current.children[element]!
        }
        current.isTerminating = true
    }
    
    func contains(_ collection: T) -> Bool {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return false
            }
            current = child
        }
        return current.isTerminating
    }
    
    func remove(_ collection: T) {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            current = child
        }
        guard current.isTerminating else {
            return
        }
        current.isTerminating = false
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.value!] = nil
            current = parent
        }
    }
}

extension Trie where T: RangeReplaceableCollection {
    func collections(startingWith prefix: T) -> [T] {
        var current = root
        for element in prefix {
            guard let child = current.children[element] else {
                return []
            }
            current = child
        }
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: T, after node: Node) -> [T] {
        var results: [T] = []
        if node.isTerminating {
            results.append(prefix)
        }
        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.value!)
            results.append(contentsOf: collections(startingWith: prefix, after: child))
        }
        return results
    }
}

func example() {
    let trie = Trie<String>()
    trie.insert("cut")
    trie.insert("cute")
    print("\n*** Prefixed With cu ***")
    let prefixedWithCu = trie.collections(startingWith: "cu")
    print(prefixedWithCu)
    print("\n*** Before removing ***")
    assert(trie.contains("cut"))
    print("\"cut\" is in the trie")
    assert(trie.contains("cute"))
    print("\"cute\" is in the trie")
    print("\n*** After removing cut ***")
    trie.remove("cut")
    assert(!trie.contains("cut"))
    assert(trie.contains("cute"))
    print("\"cute\" is still in the trie")
}


example()
