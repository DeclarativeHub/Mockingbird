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

class FramedNodeModifier: TransformModifier {

    class Container: UIView {

        var alignment: Alignment = .center

        var view: UIView {
            return subviews.first!
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let size = view.systemLayoutSizeFitting(bounds.size)
            view.frame.size = size
            switch alignment.vertical {
            case .top, .firstTextBaseline:
                view.frame.origin.y = 0
            case .center:
                view.frame.origin.y = center.y - size.height / 2
            case .bottom, .lastTextBaseline:
                view.frame.origin.y = bounds.maxY - size.height
            }
            switch alignment.horizontal {
            case .leading:
                view.frame.origin.x = 0
            case .center:
                view.frame.origin.x = center.x - size.width / 2
            case .trailing:
                view.frame.origin.x = bounds.maxX - size.width
            }
        }
    }

    private var currentModifier: Framed?

    private let container: Container = {
        let view = Container()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var constraint: (
        top: NSLayoutConstraint?,
        bottom: NSLayoutConstraint?,
        leading: NSLayoutConstraint?,
        trailing: NSLayoutConstraint?,
        width: NSLayoutConstraint?,
        height: NSLayoutConstraint?
    )

    required init(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
    }

    func update(_ modifier: Framed) {
        guard currentModifier != modifier else { return }
        currentModifier = modifier
        let view = container.view
        container.alignment = modifier.alignment
        if let width = modifier.width {
            constraint.leading?.isActive = false
            constraint.trailing?.isActive = false
            constraint.width = constraint.width ?? container.widthAnchor.constraint(equalToConstant: width)
            constraint.width!.constant = width
            constraint.width!.isActive = true
        } else {
            constraint.width?.isActive = false
            constraint.leading = constraint.leading ?? container.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            constraint.leading!.isActive = true
            constraint.trailing = constraint.trailing ?? container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            constraint.trailing!.isActive = true
        }
        if let height = modifier.height {
            constraint.top?.isActive = false
            constraint.bottom?.isActive = false
            constraint.height = constraint.height ?? container.heightAnchor.constraint(equalToConstant: height)
            constraint.height!.constant = height
            constraint.height!.isActive = true
        } else {
            constraint.height?.isActive = false
            constraint.top = constraint.top ?? container.topAnchor.constraint(equalTo: view.topAnchor)
            constraint.top!.isActive = true
            constraint.bottom = constraint.bottom ?? container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            constraint.bottom!.isActive = true
        }
    }

    func modified() -> UIView {
        return container
    }
}
