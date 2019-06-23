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

struct ClippedNodeModifier: TransformModifier {

    private let container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(view: UIView) {
        // Can we do this without two containers? Shadows need to work.
        let clipContainer = UIView(frame: .zero)
        clipContainer.translatesAutoresizingMaskIntoConstraints = false
        clipContainer.clipsToBounds = true
        container.addSubview(clipContainer)
        NSLayoutConstraint.activate([
            clipContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            clipContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            clipContainer.topAnchor.constraint(equalTo: container.topAnchor),
            clipContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        clipContainer.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: clipContainer.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: clipContainer.trailingAnchor),
            view.topAnchor.constraint(equalTo: clipContainer.topAnchor),
            view.bottomAnchor.constraint(equalTo: clipContainer.bottomAnchor)
        ])
    }

    func update(_ modifier: Clipped) {
        container.layer.cornerRadius = modifier.radius
        container.subviews.first!.layer.cornerRadius = modifier.radius
        container.layer.allowsEdgeAntialiasing = modifier.antialiased
        container.subviews.first!.layer.allowsEdgeAntialiasing = modifier.antialiased
    }

    func modified() -> UIView {
        return container
    }
}
