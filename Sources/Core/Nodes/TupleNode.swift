//
//  The MIT License (MIT)
//
//  Created by Srdan Rasic (@srdanrasic) on 22/06/2019.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public protocol _TupleNode: _Node {
    var _nodes: [_Node] { get }
}

public struct TupleNode<T>: Node, _TupleNode {

    var node: T

    public init(_ node: T) {
        self.node = node
    }

    public var content: Never {
        fatalError()
    }

    public var _nodes: [_Node] {
        if let nodes = node as? (_Node, _Node) {
            return [nodes.0, nodes.1]
        } else if let nodes = node as? (_Node, _Node, _Node) {
            return [nodes.0, nodes.1, nodes.2]
        } else if let nodes = node as? (_Node, _Node, _Node, _Node) {
            return [nodes.0, nodes.1, nodes.2, nodes.3]
        } else if let nodes = node as? (_Node, _Node, _Node, _Node, _Node) {
            return [nodes.0, nodes.1, nodes.2, nodes.3, nodes.4]
        } else if let nodes = node as? (_Node, _Node, _Node, _Node, _Node, _Node) {
            return [nodes.0, nodes.1, nodes.2, nodes.3, nodes.4, nodes.5]
        } else {
            fatalError()
        }
    }
}
