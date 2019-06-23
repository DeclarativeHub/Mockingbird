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

@_functionBuilder public struct LayoutBuilder {

    public static func buildBlock<Content>(_ content: Content) -> Content where Content: Node {
        return content
    }

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleNode<(C0, C1)> where C0: Node, C1: Node {
        return TupleNode((c0, c1))
    }

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> TupleNode<(C0, C1, C2)> where C0: Node, C1: Node, C2: Node {
        return TupleNode((c0, c1, c2))
    }

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleNode<(C0, C1, C2, C3)> where C0: Node, C1: Node, C2: Node, C3: Node {
        return TupleNode((c0, c1, c2, c3))
    }

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleNode<(C0, C1, C2, C3, C4)> where C0: Node, C1: Node, C2: Node, C3: Node, C4: Node {
        return TupleNode((c0, c1, c2, c3, c4))
    }
}
