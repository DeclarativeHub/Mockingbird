//
//  ViewModifiers.EdgesIgnoringSafeArea.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/12/2019.
//

extension ViewModifiers {

    public struct EdgesIgnoringSafeArea: ViewModifier {

        public let edges: Edge.Set

        @inlinable
        public init(edges: Edge.Set) {
            self.edges = edges
        }
    }
}

extension View {
    
    @inlinable
    public func edgesIgnoringSafeArea(_ edges: Edge.Set) -> ModifiedContent {
        return modifier(ViewModifiers.EdgesIgnoringSafeArea(edges: edges))
    }
}
