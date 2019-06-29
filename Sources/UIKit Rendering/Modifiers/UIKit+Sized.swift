//
//  UIKit+Sized.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 27/06/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import UIKit
import ReactiveKit

class SizedNodeModifier: TransformModifier {

    private var currentModifier: Sized?

    private class Container: UIView {

        var currentConstraints: [NSLayoutConstraint] = []

        var size: (width: CGFloat?, height: CGFloat?) {
            didSet {
                resetConstraints()
            }
        }

        override func didMoveToSuperview() {
            super.didMoveToSuperview()
            resetConstraints()
        }

        private func resetConstraints() {
            guard let superview = superview else { return }
            currentConstraints.forEach { $0.isActive = false }
            currentConstraints.removeAll(keepingCapacity: true)
            if let width = size.width {
                let constraints = [
                    widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: width, constant: 0),
                    centerXAnchor.constraint(equalTo: superview.centerXAnchor)
                ]
                NSLayoutConstraint.activate(constraints)
                currentConstraints.append(contentsOf: constraints)
            } else {
                let constraints = [
                    leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
                    trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor)
                ]
                NSLayoutConstraint.activate(constraints)
                currentConstraints.append(contentsOf: constraints)
            }
            if let height = size.height {
                let constraints = [
                    heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: height, constant: 0),
                    centerYAnchor.constraint(equalTo: superview.centerYAnchor)
                ]
                NSLayoutConstraint.activate(constraints)
                currentConstraints.append(contentsOf: constraints)
            } else {
                let constraints = [
                    topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
                    bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor)
                ]
                NSLayoutConstraint.activate(constraints)
                currentConstraints.append(contentsOf: constraints)
            }
        }
    }

    private let container: Container = {
        let view = Container()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }

    func update(_ modifier: Sized) {
        guard currentModifier != modifier else { return }
        currentModifier = modifier
        container.size = (modifier.width, modifier.height)
    }

    func modified() -> UIView {
        return container
    }
}
