//
//  ContentGeometry.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 15/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import CoreGraphics

/// Represents geometry of a container view content.
public struct ContentGeometry: Equatable {

    /// Ideal child bounding size.
    public let idealSize: CGSize

    /// Frames of child views relative to the container.
    public let frames: [CGRect]

    @inlinable
    public init(idealSize: CGSize, frames: [CGRect]) {
        self.idealSize = idealSize
        self.frames = frames
    }
}
