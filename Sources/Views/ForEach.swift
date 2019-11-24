//
//  ForEach.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 04/11/2019.
//

public struct ForEach<Data, ID>: View, ViewList where Data: RandomAccessCollection, ID: Hashable {

    public var data: Data
    public var content: (Data.Element) -> View

    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> View) {
        self.data = data
        self.content = content
    }

    public var body: View {
        fatalError()
    }

    func makeViews() -> [View] {
        return data.map { content($0) }
    }
}

//extension ForEach where ID == Data.Element.ID, Data.Element: Identifiable {
//    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content)
//}

extension ForEach where Data == Range<Int>, ID == Int {

    public init(_ data: Range<Int>, content: @escaping (Int) -> View) {
        self.data = data
        self.content = content
    }
}
