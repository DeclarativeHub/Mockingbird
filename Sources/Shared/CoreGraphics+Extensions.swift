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

extension CGFloat {

    @inlinable
    public func roundedToScale(scale: CGFloat, rule: FloatingPointRoundingRule) -> CGFloat {
        let scale: CGFloat = 1.0 / scale
        return scale * (self / scale).rounded(rule)
    }
}

extension CGSize {

    @inlinable
    public func roundedToScale(scale: CGFloat) -> CGSize {
        return CGSize(
            width: width.roundedToScale(scale: scale, rule: .awayFromZero),
            height: height.roundedToScale(scale: scale, rule: .awayFromZero)
        )
    }
}

extension CGPoint {

    @inlinable
    public func roundedToScale(scale: CGFloat) -> CGPoint {
        return CGPoint(
            x: x.roundedToScale(scale: scale, rule: .toNearestOrAwayFromZero),
            y: y.roundedToScale(scale: scale, rule: .toNearestOrAwayFromZero)
        )
    }
}

extension CGRect {

    @inlinable
    public func roundedToScale(scale: CGFloat) -> CGRect {
        return CGRect(
            origin: origin.roundedToScale(scale: scale),
            size: size.roundedToScale(scale: scale)
        )
    }
}
