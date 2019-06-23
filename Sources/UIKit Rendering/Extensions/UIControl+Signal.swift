//
//  The MIT License (MIT)
//
//  Created by Srdan Rasic (@srdanrasic) on 22/06/2019.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import ReactiveKit

extension ReactiveExtensions where Base: UIControl {

    public func controlEvents(_ events: UIControl.Event) -> SafeSignal<Void> {
        let base = self.base
        return Signal { [weak base] observer in
            guard let base = base else {
                observer.receive(completion: .finished)
                return NonDisposable.instance
            }
            let target = _ControlTarget(control: base, events: events) {
                observer.receive()
            }
            return BlockDisposable {
                target.unregister()
            }
            }.take(until: base.deallocated)
    }
}

@objc fileprivate class _ControlTarget: NSObject {
    private weak var control: UIControl?
    private let observer: () -> Void
    private let events: UIControl.Event

    fileprivate init(control: UIControl, events: UIControl.Event, observer: @escaping () -> Void) {
        self.control = control
        self.events = events
        self.observer = observer

        super.init()

        control.addTarget(self, action: #selector(actionHandler), for: events)
    }

    @objc private func actionHandler() {
        observer()
    }

    fileprivate func unregister() {
        control?.removeTarget(self, action: nil, for: events)
    }

    deinit {
        unregister()
    }
}
