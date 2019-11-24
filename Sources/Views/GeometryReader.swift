//
//  GeometryReader.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

public struct GeometryReader: View {

    public var content: (GeometryProxy) -> View

    public init(@ViewBuilder content: @escaping (GeometryProxy) -> View) {
        self.content = content
    }

    public var body: View {
        fatalError()
    }
}
