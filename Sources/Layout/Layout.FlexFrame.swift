//
//  FlexFrameLayout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layout {

    public struct FlexFrame {

        public let modifer: ViewModifiers.FlexFrame

        /// Modified node
        public let node: LayoutNode

        /// Screen scale
        public let screenScale: CGFloat

        public init(flexFrame: ViewModifiers.FlexFrame, node: LayoutNode, screenScale: CGFloat = 2) {
            self.modifer = flexFrame
            self.node = node
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize) -> ContentGeometry {
            var idealSize = targetSize

            if let minWidth = modifer.minWidth {
                idealSize.width = max(idealSize.width, minWidth)
            }
            if let maxWidth = modifer.maxWidth {
                idealSize.width = min(idealSize.width, maxWidth)
            }
            if let minHeight = modifer.minHeight {
                idealSize.height = max(idealSize.height, minHeight)
            }
            if let maxHeight = modifer.maxHeight {
                idealSize.height = min(idealSize.height, maxHeight)
            }

            var size = node.layoutSize(fitting: idealSize)
            size.width = clamp(idealSize.width, min: modifer.minWidth ?? size.width, max: modifer.maxWidth ?? size.width)
            size.height = clamp(idealSize.height, min: modifer.minHeight ?? size.height, max: modifer.maxHeight ?? size.height)

            let rect: CGRect

            switch modifer.alignment {
            case .center:
                rect = CGRect(
                    x: (idealSize.width - size.width) / 2,
                    y: (idealSize.height - size.height) / 2,
                    width: size.width,
                    height: size.height
                )
            default:
                fatalError("TODO")
            }

            return ContentGeometry(idealSize: idealSize, frames: [rect])
        }
    }
}

private func clamp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
    return Swift.min(Swift.max(value, min), max)
}
