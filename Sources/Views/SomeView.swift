//
//  SomeView.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 29/02/2020.
//  Copyright © 2020 Declarative Hub. All rights reserved.
//

import Foundation

public protocol SomeView {

    static var typeIdentifier: String { get }

    var body: SomeView { get }
    
}
