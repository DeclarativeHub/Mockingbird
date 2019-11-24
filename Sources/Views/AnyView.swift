//
//  AnyView.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 17/11/2019.
//

public struct AnyView: View, ViewList {

    public let content: View

    public init(_ content: View) {
        self.content = content
    }

    public var body: View {
        return content.body
    }

    func makeViews() -> [View] {
        return [content]
    }
}
