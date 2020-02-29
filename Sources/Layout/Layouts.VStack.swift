//
//  Layout.VStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layouts {

    public struct VStack: Layout, Equatable {

        public let alignment: HorizontalAlignment
        public let spacing: CGFloat?

        @inlinable
        public init(alignment: HorizontalAlignment, spacing: CGFloat?) {
            self.alignment = alignment
            self.spacing = spacing
        }

        public func layoutAlgorithm(nodes: [LayoutNode], env: EnvironmentValues) -> LayoutAlgorithm {
            return LayoutAlgorithms.VStack(nodes: nodes, layout: self, defaultSpacing: env.vStackSpacing)
        }
    }
}
