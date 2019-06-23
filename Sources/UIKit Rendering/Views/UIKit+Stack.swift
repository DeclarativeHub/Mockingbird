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

class StackController: NodeController {

    private let resolver = NodeResolver()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let nodes: Signal<[UIView], Never>

    init() {
        nodes = Signal(just: [stackView])
    }

    func update(_ stack: _Stack, axis: NSLayoutConstraint.Axis, context: Context) {
        stackView.bag.dispose()
        stackView.axis = axis
        stackView.spacing = 10

        resolver.resolve(stack._child.flattened, context: context)
            .bind(to: stackView, context: .main) { (stackView, newViews) in
                let newViews = newViews.flatMap { $0 }
                stackView.arrangedSubviews.forEach { subview in
                    if !newViews.contains(subview) { subview.removeFromSuperview() }
                }
                var viewsToAnimateIn: [UIView] = []
                newViews.enumerated().forEach { (index, newView) in
                    if let currentIndex = stackView.arrangedSubviews.firstIndex(of: newView) {
                        if currentIndex != index {
                            // Is this alright?
                            stackView.insertArrangedSubview(newView, at: index)
                        } else {
                            // nothing to do here
                        }
                    } else {
                        stackView.insertArrangedSubview(newView, at: index)
                        viewsToAnimateIn.append(newView)
                    }
                    if let animation = context.animation {
                        viewsToAnimateIn.forEach { $0.isHidden = true }
                        animation.animate {
                            viewsToAnimateIn.forEach { $0.isHidden = false }
                        }
                    }
                }
            }.dispose(in: stackView.bag)
    }
}
