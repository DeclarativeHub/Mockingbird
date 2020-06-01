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

public struct EnvironmentValues: Hashable {

    public init() {}

    // MARK: Global

    public var foregroundColor: Color? = .black

    public var accentColor: Color? = .blue

    public var vStackSpacing: CGFloat = 0

    public var hStackSpacing: CGFloat = 10

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
