//
//  VStackLayout.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layout {

    /// A VStack layout is just an HStack layout flipped in axis :)
    public struct VStackLayout {

        private var hStackLayout: Layout.HStack

        public var nodes: [LayoutNode] {
            hStackLayout.nodes
        }

        public var interItemSpacing: CGFloat {
            hStackLayout.interItemSpacing
        }

        public var screenScale: CGFloat {
            hStackLayout.screenScale
        }

        public init(nodes: [LayoutNode], interItemSpacing: CGFloat, screenScale: CGFloat = 2) {
            hStackLayout = Layout.HStack(
                nodes: nodes.map { $0.axisFlipped() },
                interItemSpacing: interItemSpacing,
                screenScale: screenScale
            )
        }

        public func contentLayout(fittingSize targetSize: CGSize, alignment: HorizontalAlignment) -> ContentGeometry {
            hStackLayout.contentLayout(
                fittingSize: CGSize(width: targetSize.height, height: targetSize.width),
                alignment: alignment.flipped
            ).flipped()
        }
    }
}

private extension ContentGeometry {

    func flipped() -> ContentGeometry {
        .init(
            idealSize: CGSize(width: idealSize.height, height: idealSize.width),
            frames: frames.map {
                CGRect(x: $0.minY, y: $0.minX, width: $0.height, height: $0.width)
            }
        )
    }
}

