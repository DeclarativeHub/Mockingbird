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
import ReactiveKit
import UIKit

public class NodeResolver {

    private var cache: [NodeController] = []
    private var inUse: [NodeController] = []

    public init() {
    }

    public func resolve(_ nodes: [_Node], context: Context) -> Signal<[[UIView]], Never> {
        beginPass(); defer { endPass() }
        return Signal(
            combiningLatest: nodes.map { self.resolveSingle($0, context: context) },
            combine: { $0 }
        )
    }
    public func resolve(_ node: _Node, context: Context) -> Signal<[UIView], Never> {
        beginPass(); defer { endPass() }
        return resolveSingle(node, context: context)
    }

    private func resolveSingle(_ node: _Node, context: Context) -> Signal<[UIView], Never> {
        switch node {
        case let node as _VerticalStack:
            let controller = take(firstOrNew: StackController())
            controller.update(node, axis: .vertical, alignment: node.alignment.stackViewAlignment, context: context)
            return controller.nodes
        case let node as _HorizontalStack:
            let controller = take(firstOrNew: StackController())
            controller.update(node, axis: .horizontal, alignment: node.alignment.stackViewAlignment, context: context)
            return controller.nodes
        case let node as Text:
            let controller = take(firstOrNew: TextController())
            controller.update(node, context: context)
            return controller.nodes
        case let node as _Button:
            let controller = take(firstOrNew: ButtonNodeController())
            controller.update(node, context: context)
            return controller.nodes
        case let node as _Repeated:
            let controller = take(firstOrNew: ForEachController())
            controller.update(node, context: context)
            return controller.nodes
        case let node as FlexibleSpace:
            let controller = take(firstOrNew: FlexibleSpaceNodeController())
            controller.update(node, context: context)
            return controller.nodes
        case let node as AnyNode:
            return resolveSingle(node.node, context: context)
        case let node as __ModifiedNode:
            switch node._modifier {
            case let modifier as Colored:
                let controller = take(firstOrNew: TransformModifierNodeController<ColoredNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as Padded:
                let controller = take(firstOrNew: TransformModifierNodeController<PaddedNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as Framed:
                let controller = take(firstOrNew: TransformModifierNodeController<FramedNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as Sized:
                let controller = take(firstOrNew: TransformModifierNodeController<SizedNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as Hugged:
                let controller = take(firstOrNew: TransformModifierNodeController<HuggedNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as Clipped:
                let controller = take(firstOrNew: TransformModifierNodeController<ClippedNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as ShadowCaster:
                let controller = take(firstOrNew: TransformModifierNodeController<ShadowCasterNodeModifier>())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            case let modifier as _ContextModifier:
                let controller = take(firstOrNew: ContextKeyWritingModifierNodeController())
                controller.update(node._node, modifier: modifier, context: context)
                return controller.nodes
            default:
                fatalError()
            }
        default:
            let controller = take(firstOrNew: DynamicNodeController())
            controller.update(node, context: context)
            return controller.nodes
        }
    }

    private func take<T: NodeController>(firstOrNew new: @autoclosure () -> T) -> T {
        if let index = cache.firstIndex(where: { $0 is T }) {
            let element = cache.remove(at: index) as! T
            inUse.append(element)
            return element
        } else {
            let element = new()
            inUse.append(element)
            return element
        }
    }

    func beginPass() {

    }

    func endPass() {
        cache = inUse
        inUse = []
    }
}
