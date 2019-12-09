//
//  ViewModifier.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

public protocol ViewModifier {
    
    func body(content: View) -> View
}

extension ViewModifier {

    @inlinable
    public func body(content: View) -> View {
        return ModifiedContent(content: content, modifier: self)
    }
}

public enum ViewModifiers {}
