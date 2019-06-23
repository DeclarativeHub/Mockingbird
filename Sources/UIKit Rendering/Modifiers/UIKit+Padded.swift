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

class PaddedNodeModifier: TransformModifier {

    private var currentModifier: Padded?

    private var constraint: (
        top: NSLayoutConstraint?,
        bottom: NSLayoutConstraint?,
        leading: NSLayoutConstraint?,
        trailing: NSLayoutConstraint?
    )

    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
    }

    func update(_ modifier: Padded) {
        guard currentModifier != modifier else { return }
        currentModifier = modifier
        let view = container.subviews.first!
        constraint.top = constraint.top ?? view.topAnchor.constraint(equalTo: container.topAnchor)
        constraint.top!.constant = modifier.insets.top
        constraint.top!.isActive = true
        constraint.bottom = constraint.bottom ?? view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        constraint.bottom!.constant = -modifier.insets.bottom
        constraint.bottom!.isActive = true
        constraint.leading = constraint.leading ?? view.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        constraint.leading!.constant = modifier.insets.left
        constraint.leading!.isActive = true
        constraint.trailing = constraint.trailing ?? view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        constraint.trailing!.constant = -modifier.insets.right
        constraint.trailing!.isActive = true
    }

    func modified() -> UIView {
        return container
    }
}
