//
//  EnvironmentObjectModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 26/11/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import Foundation

extension ViewModifiers {

    public struct EnvironmentObject: ViewModifier {

        public let object: Any
        public let objectTypeIdentifier: String

        public init(_ object: Any, objectTypeIdentifier: String) {
            self.object = object
            self.objectTypeIdentifier = objectTypeIdentifier
        }
    }
}

extension View {

    @inlinable public func environmentObject<B>(_ object: B) -> ModifiedContent {
        return modifier(ViewModifiers.EnvironmentObject(object, objectTypeIdentifier: String(reflecting: B.self)))
    }

}
