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

extension ViewModifiers {

    public struct AspectRatio: ViewModifier {

        public let aspectRatio: CGFloat?
        public let contentMode: ContentMode

        @inlinable
        public init(_ aspectRatio: CGFloat?, contentMode: ContentMode) {
            self.aspectRatio = aspectRatio
            self.contentMode = contentMode
        }
    }
}

extension View {

    @inlinable public func aspectRatio(_ aspectRatio: CGFloat? = nil, contentMode: ContentMode) -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        modifier(ViewModifiers.AspectRatio(aspectRatio, contentMode: contentMode))
    }

    @inlinable public func aspectRatio(_ aspectRatio: CGSize, contentMode: ContentMode) -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        modifier(ViewModifiers.AspectRatio(aspectRatio.width / aspectRatio.height, contentMode: contentMode))
    }

    @inlinable public func scaledToFit() -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        aspectRatio(contentMode: .fit)
    }

    @inlinable public func scaledToFill() -> ModifiedContent<Self, ViewModifiers.AspectRatio> {
        aspectRatio(contentMode: .fill)
    }

}
