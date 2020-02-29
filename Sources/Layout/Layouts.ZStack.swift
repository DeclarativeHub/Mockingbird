//
//  Layout.ZStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

extension Layouts {

    public struct ZStack: Layout, Equatable {

        public let alignment: Alignment

        @inlinable
        public init(alignment: Alignment = .center) {
            self.alignment = alignment
        }

        public func layoutAlgorithm(nodes: [LayoutNode], env: EnvironmentValues) -> LayoutAlgorithm {
            return LayoutAlgorithms.ZStack(nodes: nodes, layout: self)
        }
    }
}
