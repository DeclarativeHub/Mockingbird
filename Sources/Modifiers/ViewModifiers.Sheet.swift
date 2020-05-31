//
//  ViewModifiers.Sheet.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 31/05/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

extension ViewModifiers {

    public struct Sheet<Content: View>: ViewModifier {

        public static var typeIdentifier: String {
            "Sheet"
        }

        public typealias Body = Swift.Never

        public let isPresented: Binding<Bool>
        public let onDismiss: (() -> Void)?
        public let content: () -> Content

        @inlinable
        public init(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
            self.isPresented = isPresented
            self.onDismiss = onDismiss
            self.content = content
        }
    }

}

extension View {

    public func sheet<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> ModifiedContent<Self, ViewModifiers.Sheet<Content>> {
        modifier(ViewModifiers.Sheet(isPresented: isPresented, onDismiss: onDismiss, content: content))
    }
}
