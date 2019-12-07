//
//  Image.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 23/11/2019.
//

import Foundation

public struct Image: View, Hashable {

    public let name: String
    public let bundle: Bundle?

    public init(_ name: String, bundle: Bundle? = nil) {
        self.name = name
        self.bundle = bundle
    }

    public var body: View {
        fatalError()
    }
}
