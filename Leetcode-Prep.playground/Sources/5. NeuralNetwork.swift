import Foundation

extension ClosedRange where Bound: FloatingPoint {
    func random() -> Bound {
        let range = self.upperBound - self.lowerBound
        let randomValue = (Bound(arc4random_uniform(UINT32_MAX)) / Bound(UINT32_MAX)) * range + self.lowerBound
        return randomValue
    }
}

class Layer {
    private var output: [Float]
    private var input: [Float]
    private var weights: [Float]
    private var previousWeights: [Float]
    
    init(inputSize: Int, outputSize: Int) {
        self.output = [Float](repeating: 0, count: outputSize)
        self.input = [Float](repeating: 0, count: inputSize + 1)
        self.weights = (0..<(1 + inputSize) * outputSize).map { _ in
            return (-2.0...2.0).random()
        }
        previousWeights = [Float](repeating: 0, count: weights.count)
    }
    
    func run(inputArray: [Float]) -> [Float] {
        for i in 0..<inputArray.count {
            input[i] = inputArray[i]
        }
        
        input[input.count-1] = 1
        var offSet = 0
        
        for i in 0..<output.count {
            for j in 0..<input.count {
                output[i] += weights[offSet+j] * input[j]
            }
            output[i] = ActivationFunction.sigmoid(x: output[i])
            offSet += input.count
        }
        return output
    }
    
    func train(error: [Float], learningRate: Float, momentum: Float) -> [Float] {
        var offset = 0
        var nextError = [Float](repeating: 0, count: input.count)
        for i in 0..<output.count {
            let delta = error[i] * ActivationFunction.sigmoidDerivative(x: output[i])
            for j in 0..<input.count {
                let weightIndex = offset + j
                nextError[j] = nextError[j] + weights[weightIndex] * delta
                let dw = input[j] * delta * learningRate
                weights[weightIndex] += previousWeights[weightIndex] * momentum + dw
                previousWeights[weightIndex] = dw
            }
            offset += input.count
        }
        return nextError
    }
}

class ActivationFunction {
    static func sigmoid(x: Float) -> Float {
        return 1 / (1 + exp(-x))
    }
    static func sigmoidDerivative(x: Float) -> Float {
        return x * (1 - x)
    }
}

class NeuralNetwork {
    static var learningRate: Float = 0.3
    static var momentum: Float = 0.6
    static var iterations: Int = 10000
    private var layers: [Layer] = []
    
    init(inputSize: Int, hiddenSize: Int, outputSize: Int) {
        self.layers.append(Layer(inputSize: inputSize, outputSize: hiddenSize))
        self.layers.append(Layer(inputSize: hiddenSize, outputSize: outputSize))
    }
    
    func run(input: [Float]) -> [Float] {
        var activations = input
        for i in 0..<layers.count {
            activations = layers[i].run(inputArray: activations)
        }
        return activations
    }
    
    func train(input: [Float], targetOutput: [Float], learningRate: Float, momentum: Float) {
        let calculatedOutput = run(input: input)
        var error = zip(targetOutput, calculatedOutput).map { $0 - $1 }
        for i in (0...layers.count-1).reversed() {
            error = layers[i].train(error: error, learningRate: learningRate, momentum: momentum)
        }
    }
}


let traningData: [[Float]] = [ [0,0], [0,1], [1,0], [1,1] ]
let traningResults: [[Float]] = [ [0], [0], [0], [1] ]
let backProb = NeuralNetwork(inputSize: 2, hiddenSize: 3, outputSize: 1)

func run() {
    for _ in 0..<NeuralNetwork.iterations {
        for i in 0..<traningResults.count {
            backProb.train(input: traningData[i], targetOutput: traningResults[i], learningRate: NeuralNetwork.learningRate, momentum: NeuralNetwork.momentum)
        }
        
        for i in 0..<traningResults.count {
            var t = traningData[i]
            print("\(t[0]), \(t[1])  -- \(backProb.run(input: t)[0])")
        }
    }
}
