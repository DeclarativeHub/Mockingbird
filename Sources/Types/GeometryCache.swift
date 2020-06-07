//
//  GeometryCache.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import Foundation

public struct GeometryCache {

    public var pass: LayoutPass = .init()
    public var geometry: [CGSize: ContentGeometry] = [:]

    public init() {}

    public func geometry(for pass: LayoutPass, size: CGSize) -> ContentGeometry? {
        guard self.pass == pass else { return nil }
        return geometry[size]
    }

    public mutating func update(pass: LayoutPass, size: CGSize, geometry: ContentGeometry) {
        if self.pass != pass {
            self.pass = pass
            self.geometry.removeAll(keepingCapacity: true)
        }
        self.geometry[size] = geometry
    }
}
