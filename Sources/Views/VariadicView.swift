//
//  VariadicView.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 28/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import Foundation

public enum VariadicView: View {

    public typealias Body = Swift.Never

    public struct Tree<Root: Layout, Content: View>: View {

        public typealias Body = Swift.Never

        public var root: Root
        public var content: Content

        @inlinable
        internal init(root: Root, content: Content) {
            self.root = root
            self.content = content
        }

        @inlinable
        public init(_ root: Root, @ViewBuilder content: () -> Content) {
            self.root = root
            self.content = content()
        }
    }
}
