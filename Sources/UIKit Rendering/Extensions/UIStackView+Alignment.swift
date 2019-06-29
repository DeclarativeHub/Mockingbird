//
//  UIStackView+Alignment.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 29/06/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

import UIKit

extension VerticalAlignment {

    var stackViewAlignment: UIStackView.Alignment {
        switch self {
        case .center:
            return .center
        case .top:
            return .top
        case .firstTextBaseline:
            return .firstBaseline
        case .lastTextBaseline:
            return .lastBaseline
        case .bottom:
            return .bottom
        }
    }
}

extension HorizontalAlignment {

    var stackViewAlignment: UIStackView.Alignment {
        switch self {
        case .center:
            return .center
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

