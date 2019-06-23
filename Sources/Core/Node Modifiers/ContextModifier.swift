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

protocol _ContextModifier {
    func modify(_ context: Context) -> Context
}

public struct ContextModifier<Value>: NodeModifier, _ContextModifier {

    let keyPath: WritableKeyPath<Context, Value>
    let value: Value

    init(_ keyPath: WritableKeyPath<Context, Value>, _ value: Value) {
        self.keyPath = keyPath
        self.value = value
    }

    func modify(_ context: Context) -> Context {
        var context = context
        context[keyPath: keyPath] = value
        return context
    }
}

extension Node {

    public func foregroundColor(_ color: Color?) -> ModifiedNode<Self, ContextModifier<Color?>> {
        return modified(ContextModifier(\.textColor, color))
    }

    public func lineLimit(_ lineLimit: Int?) -> ModifiedNode<Self, ContextModifier<Int?>> {
        return modified(ContextModifier(\.lineLimit, lineLimit))
    }

    public func font(_ font: Font?) -> ModifiedNode<Self, ContextModifier<Font?>> {
        return modified(ContextModifier(\.font, font))
    }

    public func animation(_ animation: Animation?) -> ModifiedNode<Self, ContextModifier<Animation?>> {
        return modified(ContextModifier(\.animation, animation))
    }
}
