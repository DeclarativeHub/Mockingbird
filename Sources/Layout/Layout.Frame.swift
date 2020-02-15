//
//  FrameLayout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layout {

    public struct Frame {

        public let frame: ViewModifiers.Frame

        /// Modified node
        public let node: LayoutNode

        /// Screen scale
        public let screenScale: CGFloat

        public init(frame: ViewModifiers.Frame, node: LayoutNode, screenScale: CGFloat = 2) {
            self.frame = frame
            self.node = node
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize) -> ContentGeometry {
            var targetSize = targetSize
            if let width = frame.width {
                targetSize.width = min(targetSize.width, width)
            }
            if let height = frame.height {
                targetSize.height = min(targetSize.height, height)
            }

            var viewSize = node.layoutSize(fitting: targetSize)
            if let width = frame.width {
                viewSize.width = max(viewSize.width, width)
            }
            if let height = frame.height {
                viewSize.height = max(viewSize.height, height)
            }

            let rect: CGRect
            switch frame.alignment {
            case .center:
                rect = CGRect(
                    x: (targetSize.width - viewSize.width) / 2,
                    y: (targetSize.height - viewSize.height) / 2,
                    width: viewSize.width,
                    height: viewSize.height
                )
            default:
                fatalError("TODO")
            }

            return ContentGeometry(idealSize: rect.size, frames: [rect])
        }
    }
}
