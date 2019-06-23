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

public protocol __ModifiedNode: _NodeModifier {
    var _node: _Node { get }
    var _modifier: _NodeModifier { get }
}

public struct ModifiedNode<ChildNode: Node, Modifier: NodeModifier>: Node, __ModifiedNode {

    public let node: ChildNode
    public let modifier: Modifier

    public init(node: ChildNode, modifier: Modifier) {
        self.node = node
        self.modifier = modifier
    }

    public var content: Never {
        fatalError()
    }

    public var _node: _Node {
        return node
    }

    public var _modifier: _NodeModifier {
        return modifier
    }
}

extension Node {

    @inlinable public func modified<T>(_ modifier: T) -> ModifiedNode<Self, T> where T: NodeModifier {
        return ModifiedNode(node: self, modifier: modifier)
    }
}
