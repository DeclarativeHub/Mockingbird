//
//  GeometryProxy.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

import CoreGraphics

public struct GeometryProxy {

    public var size: CGSize
    public var safeAreaInsets: EdgeInsets

    private let getFrame: (CoordinateSpace) -> CGRect

    public init(size: CGSize, safeAreaInsets: EdgeInsets, getFrame: @escaping (CoordinateSpace) -> CGRect) {
        self.size = size
        self.safeAreaInsets = safeAreaInsets
        self.getFrame = getFrame
    }

    public func frame(in coordinateSpace: CoordinateSpace) -> CGRect {
        return getFrame(coordinateSpace)
    }
}
