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

import Mockingbird

struct RootNode: Node {

    @State var count: Int = 1

    var content: some Node {
        VerticalStack {
            Repeated(0..<count) { _ in
                Button(action: { self.count += 1 }) {
                    BoxedText()
                }
            }
        }
        .cornerRadius(20)
        .shadow(radius: 20)
        .animation(.spring)
    }
}

struct BoxedText: Node {

    let colors = [Color.red, .orange, .yellow, .green, .blue, .purple]

    var content: some Node {
        // Credits for this lovely node go to https://twitter.com/ericasadun/status/1136359269115355138  👏
        colors.reduce(AnyNode(Text("👭").font(.largeTitle))) {
            AnyNode($0.padding().background($1))
        }
    }
}
