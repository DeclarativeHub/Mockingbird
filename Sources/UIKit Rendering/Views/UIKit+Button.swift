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

import UIKit
import ReactiveKit

class ButtonNodeController: NodeController, DisposeBagProvider {

    let bag = DisposeBag()

    var nodes: Signal<[UIView], Never>

    private let updates = ReplayOneSubject<(node: _Button, context: Context), Never>()

    init() {
        let resolver = NodeResolver()
        nodes = updates.flatMapLatest { (update) -> Signal<[UIView], Never> in
            var context = update.context
            context.textColor = context.accentColor
            return resolver.resolve(update.node._child, context: context).mapElement { (view) -> UIView in
                _ = view.reactive.tapGesture().bind(to: view, context: .immediate) { view, _ in
                    update.node.action()
                }
                return view
            }
        }.share(limit: 1)
    }

    func update(_ node: _Button, context: Context) {
        updates.send((node, context))
    }
}
