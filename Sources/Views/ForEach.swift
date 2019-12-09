//
//  ForEach.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

public struct ForEach<Data, ID>: View, ViewList where Data: RandomAccessCollection, ID: Hashable {

    public var data: Data
    public var content: (Data.Element) -> View

    @inlinable
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> View) {
        self.data = data
        self.content = content
    }

    public var body: View {
        fatalError()
    }

    @inlinable
    public func makeViews() -> [View] {
        return data.map { content($0) }
    }
}

//extension ForEach where ID == Data.Element.ID, Data.Element: Identifiable {
//    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content)
//}

extension ForEach where Data == Range<Int>, ID == Int {

    @inlinable
    public init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> View) {
        self.data = data
        self.content = content
    }
}
