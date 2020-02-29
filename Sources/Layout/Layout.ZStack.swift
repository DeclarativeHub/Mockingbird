//
//  Layout.ZStack.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

extension Layout {

    public struct ZStack: Equatable {

        public let alignment: Alignment

        @inlinable
        public init(alignment: Alignment = .center) {
            self.alignment = alignment
        }
    }
}
