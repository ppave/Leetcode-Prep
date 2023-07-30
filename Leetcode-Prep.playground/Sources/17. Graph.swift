import Foundation

// A graph is a data structure that captures relationships between objects.
// It is made up of vertices connected by edges.

// - Weighted graphs - every edge has a weight associated with it that represents the cost of using this edge
// This lets you choose the cheapest or shortest path between two vertices.
// - Directed graphs - an edge may only permit traversal in one direction
// - Undirected graphs - all edges are bidirectional



// Vertex

struct Vertex<T> {
    let index: Int
    let data: T
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}

// Edge

struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double?
}

// Graph

enum EdgeType {
    case directed
    case undirected
}

protocol Graph {
    associatedtype Element
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    // Ex: How much is the flight from Singapore to Tokyo?
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

extension Graph {
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

// AdjacencyList

class AdjacencyList<T: Hashable>: Graph {
    var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source).first { $0.destination == destination }?.weight
    }
}

// AdjacencyMatrix

class AdjacencyMatrix<T>: Graph {
    var vertices: [Vertex<T>] = []
    var weights: [[Double?]] = []
    
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(source: source, destination: vertices[column], weight: weight))
            }
        }
        return edges
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        weights[source.index][destination.index]
    }
}

func exampleGraph() {
    let graph = AdjacencyMatrix<String>()
    
    let singapore = graph.createVertex(data: "Singapore")
    let tokyo = graph.createVertex(data: "Tokyo")
    let hongKong = graph.createVertex(data: "Hong Kong")
    let detroit = graph.createVertex(data: "Detroit")
    let sanFrancisco = graph.createVertex(data: "San Francisco")
    let washingtonDC = graph.createVertex(data: "Washington DC")
    let austinTexas = graph.createVertex(data: "Austin Texas")
    let seattle = graph.createVertex(data: "Seattle")
    
    graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
    graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
    graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
    graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
    graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
    graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
    graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
    graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
    graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
    graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
    graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
    graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
}
