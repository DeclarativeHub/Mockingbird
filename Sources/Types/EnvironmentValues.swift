//
//  Environment.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 10/11/2019.
//

import CoreGraphics

public struct EnvironmentValues: Hashable {

    public init() {}

    // MARK: Global

    public var foregroundColor: Color? = .black

    public var accentColor: Color? = .blue

    public var stackSpacing: CGFloat = 10

    public var padding: CGFloat = 10

    public var hidden: Bool = false

    // MARK: Other

    public var isEnabled: Bool = true

    public var font: Font = .body

    public var multilineTextAlignment: TextAlignment = .leading

    public var truncationMode: Text.TruncationMode = .tail

    public var lineSpacing: CGFloat = 0

    public var allowsTightening: Bool = false

    public var lineLimit: Int? = nil

    public var minimumScaleFactor: CGFloat = 1

    // MARK: Private

    public var _layoutAxis: Axis? = nil
}
