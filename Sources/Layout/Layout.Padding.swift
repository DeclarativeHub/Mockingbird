//
//  PaddingLayout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layout {

    public struct Padding {

        public let padding: ViewModifiers.Padding

        /// Modified node
        public let node: LayoutNode

        /// Screen scale
        public let screenScale: CGFloat

        public init(padding: ViewModifiers.Padding, node: LayoutNode, screenScale: CGFloat = 2) {
            self.padding = padding
            self.node = node
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize, defaultPadding: CGFloat) -> ContentGeometry {

            let insets = EdgeInsets(
                top: padding.top ?? defaultPadding,
                leading: padding.leading ?? defaultPadding,
                bottom: padding.bottom ?? defaultPadding,
                trailing: padding.trailing ?? defaultPadding
            )

            let rect = CGRect(
                x: insets.leading,
                y: insets.top,
                width: targetSize.width - CGFloat(insets.leading + insets.trailing),
                height: targetSize.height - CGFloat(insets.top + insets.bottom)
            )

            let nodeSize = node.layoutSize(fitting: rect.size)

            let idealSize = CGSize(
                width: nodeSize.width + CGFloat(insets.leading + insets.trailing),
                height: nodeSize.height + CGFloat(insets.top + insets.bottom)
            )

            return ContentGeometry(idealSize: idealSize, frames: [rect])
        }
    }
}
