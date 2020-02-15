//
//  ZStackLayout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layout {

    public struct ZStack {

        /// Nodes in the stack
        public let nodes: [LayoutNode]

        /// Screen scale
        public let screenScale: CGFloat

        public init(nodes: [LayoutNode], screenScale: CGFloat = 2) {
            self.nodes = nodes
            self.screenScale = screenScale
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize, alignment: Alignment) -> ContentGeometry {
            var idealSize: CGSize = .zero
            let frames = nodes.map { (node) -> CGRect in
                let size = node.layoutSize(fitting: targetSize)
                var alignedBounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                switch alignment.horizontal {
                case .leading:
                    alignedBounds.origin.x = 0
                case .center:
                    alignedBounds.origin.x = (targetSize.width - size.width) / 2
                case .trailing:
                    alignedBounds.origin.x = targetSize.width - size.width
                }
                switch alignment.vertical {
                case .top:
                    alignedBounds.origin.y = 0
                case .center:
                    alignedBounds.origin.y = (targetSize.height - size.height) / 2
                case .bottom:
                    alignedBounds.origin.y = targetSize.height - size.height
                case .firstTextBaseline, .lastTextBaseline:
                    fatalError()
                }
                idealSize = CGSize(width: max(idealSize.width, size.width), height: max(idealSize.height, size.height))
                return alignedBounds
            }
            return ContentGeometry(idealSize: idealSize, frames: frames)
        }
    }
}
