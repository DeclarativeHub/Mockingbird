//
//  Layout.HStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

extension Layouts {

    public struct HStack: Layout, Equatable {

        public let alignment: VerticalAlignment
        public let spacing: CGFloat?

        @inlinable
        public init(alignment: VerticalAlignment, spacing: CGFloat?) {
            self.alignment = alignment
            self.spacing = spacing
        }

        public func layoutAlgorithm(nodes: [LayoutNode], env: EnvironmentValues) -> LayoutAlgorithm {
            return LayoutAlgorithms.HStack(nodes: nodes, layout: self, defaultSpacing: env.hStackSpacing)
        }
    }
}
