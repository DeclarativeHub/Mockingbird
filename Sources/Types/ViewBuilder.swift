// MIT License
//
// Copyright (c) 2020 Declarative Hub
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@_functionBuilder
public struct ViewBuilder {

    public static func buildBlock() -> EmptyView {
        return EmptyView()
    }

    public static func buildBlock<C0>(_ c0: C0) -> C0 where C0: View {
        return c0
    }

    public static func buildIf<Content>(_ content: Content?) -> ViewContent where Content: View {
        return ViewContent(content.map { [$0] } ?? [])
    }

    public static func buildEither<TrueContent>(first: TrueContent) -> ViewContent where TrueContent: View {
        return ViewContent([first])
    }

    public static func buildEither<FalseContent>(second: FalseContent) -> ViewContent where FalseContent: View {
        return ViewContent([second])
    }

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> ViewContent where C0: View, C1: View {
        return ViewContent([c0, c1])
    }

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> ViewContent where C0: View, C1: View, C2: View {
        return ViewContent([c0, c1, c2])
    }

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> ViewContent where C0: View, C1: View, C2: View, C3: View {
        return ViewContent([c0, c1, c2, c3])
    }

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> ViewContent where C0: View, C1: View, C2: View, C3: View, C4: View {
        return ViewContent([c0, c1, c2, c3, c4])
    }

    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> ViewContent where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View {
        return ViewContent([c0, c1, c2, c3, c4, c5])
    }

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> ViewContent where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View {
        return ViewContent([c0, c1, c2, c3, c4, c5, c6])
    }

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> ViewContent where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View {
        return ViewContent([c0, c1, c2, c3, c4, c5, c6, c7])
    }

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> ViewContent where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View {
        return ViewContent([c0, c1, c2, c3, c4, c5, c6, c7, c8])
    }

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> ViewContent where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View, C9: View {
        return ViewContent([c0, c1, c2, c3, c4, c5, c6, c7, c8, c9])
    }
}
