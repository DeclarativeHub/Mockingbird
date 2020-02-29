//
//  Layout.HStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

extension Layout {

    public struct HStack: Equatable {

        public let alignment: VerticalAlignment
        public let spacing: CGFloat?

        @inlinable
        public init(alignment: VerticalAlignment, spacing: CGFloat?) {
            self.alignment = alignment
            self.spacing = spacing
        }
    }
}
