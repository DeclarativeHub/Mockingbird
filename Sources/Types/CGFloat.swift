//
//  CGFloat.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 01/06/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

#if canImport(CoreGraphics)

import CoreGraphics

public typealias CGFloat = CoreGraphics.CGFloat

#else

#if (arch(i386) || arch(arm))

public typealias CGFloat = Float

#else

public typealias CGFloat = Double

#endif

#endif
