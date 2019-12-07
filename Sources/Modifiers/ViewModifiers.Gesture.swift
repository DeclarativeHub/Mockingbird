//
//  ViewModifier.Gesture.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 07/12/2019.
//  Copyright © 2019 Declarative Hub. All rights reserved.
//

extension ViewModifiers {

    public struct Gesture: ViewModifier {

        public enum Priority {
            case low
            case high
            case simultaneous
        }

        public let gesture: AnyGesture
        public let priority: Priority

        public init(_ gesture: AnyGesture, priority: Priority) {
            self.gesture = gesture
            self.priority = priority
        }
    }
}

extension View {

    public func gesture<T>(_ gesture: T) -> ModifiedContent where T: Gesture {
        return modifier(ViewModifiers.Gesture(gesture, priority: .low))
    }

    public func highPriorityGesture<T>(_ gesture: T) -> ModifiedContent where T: Gesture {
        return modifier(ViewModifiers.Gesture(gesture, priority: .high))
    }

    public func simultaneousGesture<T>(_ gesture: T) -> ModifiedContent where T: Gesture {
        return modifier(ViewModifiers.Gesture(gesture, priority: .simultaneous))
    }
}
