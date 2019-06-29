//
//  UIKit+FlexibleSpace.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 27/06/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import UIKit
import ReactiveKit

class FlexibleSpaceNodeController: NodeController {

    internal class View: UIView {

        override var intrinsicContentSize: CGSize {
            if let stackView = superview as? UIStackView {
                if stackView.axis == .horizontal {
                    return CGSize(width: 10000, height: UIView.noIntrinsicMetric)
                } else {
                    return CGSize(width: UIView.noIntrinsicMetric, height: 10000)
                }
            }
            return .zero
        }
    }

    private let view = View()

    let nodes: Signal<[UIView], Never>

    init() {
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.setContentHuggingPriority(UILayoutPriority(85), for: .vertical)
//        view.setContentHuggingPriority(UILayoutPriority(85), for: .horizontal)
        view.setContentCompressionResistancePriority(UILayoutPriority(45), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(45), for: .horizontal)
        nodes = Signal(just: [view])
    }

    func update(_ node: FlexibleSpace, context: Context) {
    }
}
