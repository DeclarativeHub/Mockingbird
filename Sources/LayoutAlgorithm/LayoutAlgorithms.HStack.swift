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

extension LayoutAlgorithms {

    /// Stack layout is calculated using the algorithm below.
    ///
    ///     1. Group nodes by layout priority into layout groups, descending.
    ///     2. Determine the minimal width of all nodes and all priority groups.
    ///     3. For each priority group:
    ///         1. Available group width is the targetSize.width - spacings - minimal width of all other priority groups.
    ///         2. Divide the available group width by the number of nodes in the group, splitting the available width into equal parts.
    ///         3. Suggest the resulting width to each node to calculate nodes' size and track the total group width as we go.
    ///         4. If the total group width exceeds the available group width, proportionally shrink all shrinkable nodes of the group.
    ///     4. If the total width of all nodes is less than the available width, then for each priority group:
    ///         1. Proportionally expand all expandable nodes into the available space.
    ///         2. Continute with the next priority group if there is more space svailable.
    ///     5. Distribute nodes along the major axis using nodes widths and spacing.
    ///     6. Distribute nodes along the minor axis using nodes heights and the given alignment.
    ///
    public struct HStack: LayoutAlgorithm {

        public let nodes: [LayoutNode]

        public let layout: Layouts.HStack

        public let screenScale: CGFloat = 2

        private let alignment: VerticalAlignment

        private let interItemSpacing: CGFloat

        public init(nodes: [LayoutNode], layout: Layouts.HStack, defaultSpacing: CGFloat) {
            self.nodes = nodes
            self.layout = layout
            self.alignment = layout.alignment
            self.interItemSpacing = layout.spacing ?? defaultSpacing
        }

        /// Calculate the stack geometry fitting `targetSize` and aligned by `alignment`.
        public func contentLayout(fittingSize targetSize: CGSize) -> ContentGeometry {
            let epsilon: CGFloat = 0.0000001
            let availableHeight = targetSize.height
            var frames = Array(repeating: CGRect.zero, count: nodes.count)

            let sortedNodes = nodes.enumerated().sorted { (lhs, rhs) -> Bool in
                return lhs.element.layoutPriority > rhs.element.layoutPriority
            }

            struct PriorityGroup {

                struct Item {
                    let index: Int
                    let node: LayoutNode
                    var minSize: CGSize
                    var maxSize: CGSize
                    var size: CGSize
                    var isShrinkable: Bool
                    var isExpandable: Bool
                    var needsHeightUpdate: Bool
                }

                var items: [Item]
                let priority: Double
                var minWidth: CGFloat
            }

            let minSize = CGSize(width: 0, height: targetSize.height)
            var priorityGroups = sortedNodes.reduce(into: [PriorityGroup]()) { (result, pair) in
                let size = pair.element.layoutSize(fitting: minSize)
                let item = PriorityGroup.Item(
                    index: pair.offset,
                    node: pair.element,
                    minSize: size,
                    maxSize: size,
                    size: size,
                    isShrinkable: true,
                    isExpandable: true,
                    needsHeightUpdate: false
                )
                guard let group = result.last else {
                    result.append(
                        PriorityGroup(items: [item], priority: item.node.layoutPriority, minWidth: item.minSize.width)
                    )
                    return
                }
                if pair.element.layoutPriority != group.priority {
                    result.append(
                        PriorityGroup(items: [item], priority: item.node.layoutPriority, minWidth: item.minSize.width)
                    )
                } else {
                    result[result.count-1].items.append(item)
                    result[result.count-1].minWidth += item.minSize.width
                }
            }

            let numberOfJunctions = nodes.reduce((count: 0, prevNode: LayoutNode?.none)) { (memo, node) in
                guard let prevNode = memo.prevNode else { return (memo.count, node) }
                if prevNode.isSpacer || node.isSpacer {
                    return (memo.count, node)
                } else {
                    return (memo.count + 1, node)
                }
            }.count

            let minimalRequiredWidth = priorityGroups.reduce(0) { $0 + $1.minWidth }
            let totalRequiredSpacing = CGFloat(numberOfJunctions) * interItemSpacing
            var availableWidth = targetSize.width - totalRequiredSpacing - minimalRequiredWidth

            priorityGroups.mutableForEach { (priorityGroup) in
                // We'll be calculating new width of this group, so restore previousely added minimum width
                availableWidth += priorityGroup.minWidth
                var groupWidth: CGFloat = 0
                let numberOfItemsInGroup = CGFloat(priorityGroup.items.count)
                let widthToSuggest = availableWidth / numberOfItemsInGroup

                // Calculate nodes' sizes
                priorityGroup.items.mutableForEach { (item) in
                    let nodeSize = item.node.layoutSize(fitting: CGSize(width: widthToSuggest, height: availableHeight))
                    item.size = nodeSize
                    item.needsHeightUpdate = false
                    item.isShrinkable = nodeSize.width < widthToSuggest + epsilon
                    groupWidth += nodeSize.width
                }

                // Shrink nodes if they exceed total available width and if possible
                while groupWidth > availableWidth + epsilon {
                    let shrinkableNodes = priorityGroup.items.enumerated().filter { $0.element.isShrinkable }
                    if shrinkableNodes.isEmpty {
                        break
                    }
                    let excessWidth = groupWidth - availableWidth
                    let shrinkageToSuggest = excessWidth / CGFloat(shrinkableNodes.count)
                    for (index, var item) in shrinkableNodes {
                        let possibleReduction = item.size.width - item.minSize.width
                        let reduction = min(possibleReduction, shrinkageToSuggest)
                        item.size.width -= reduction
                        item.isShrinkable = item.size.width > item.minSize.width + epsilon
                        item.needsHeightUpdate = true
                        priorityGroup.items[index] = item
                        groupWidth -= reduction
                    }
                }

                // Deduct group width
                availableWidth -= groupWidth
            }

            // Distribute any remaining space among nodes, respecting priority groups
            if availableWidth > epsilon {
                for (index, var priorityGroup) in priorityGroups.enumerated().reversed() {
                    while availableWidth > epsilon {
                        priorityGroup.items.mutableForEach { (item) in
                            guard item.isExpandable else {
                                return // break
                            }
                            item.maxSize = item.node.layoutSize(fitting: CGSize(width: item.size.width + availableWidth, height: availableHeight))
                            item.isExpandable = item.maxSize.width > item.size.width + epsilon
                        }
                        let expandableNodes = priorityGroup.items.enumerated().filter { $0.element.isExpandable }
                        if expandableNodes.isEmpty {
                            break
                        }
                        let expansionToSuggest = availableWidth / CGFloat(expandableNodes.count)
                        var numberOfExpansions = 0
                        for (index, var item) in expandableNodes {
                            let targetSize = CGSize(width: item.size.width + expansionToSuggest, height: availableHeight)
                            let nodeSize = item.node.layoutSize(fitting: targetSize)
                            let expandedWidth = nodeSize.width - item.size.width
                            item.size = nodeSize
                            item.needsHeightUpdate = false
                            priorityGroup.items[index] = item
                            availableWidth -= expandedWidth
                            if expandedWidth > epsilon {
                                numberOfExpansions += 1
                            }
                        }
                        if numberOfExpansions == 0 {
                            break
                        }
                    }
                    priorityGroups[index] = priorityGroup
                }
            }

            // Distribute any remaining space among spacers
            if availableWidth > epsilon {
                priorityGroups.mutableForEach { (priorityGroup) in
                    let spacers = priorityGroup.items.enumerated().filter { $0.element.node.isSpacer }
                    let widthToAdd = availableWidth / CGFloat(spacers.count)
                    for (index, _) in spacers {
                        priorityGroup.items[index].size.width += widthToAdd
                        availableWidth -= widthToAdd
                    }
                    if availableWidth < epsilon {
                        return // break
                    }
                }
            }

            // Update frames
            priorityGroups.mutableForEach { (priorityGroup) in
                priorityGroup.items.mutableForEach { (item) in
                    if item.needsHeightUpdate {
                        let targetSize = CGSize(width: item.size.width, height: availableHeight)
                        item.size = item.node.layoutSize(fitting: targetSize) // Will this override width?
                    }
                    frames[item.index].size = item.size
                }
            }

            // Calculate nodes` origins
            var movingOrigin = CGPoint.zero
            var fittingSize = CGSize(width: totalRequiredSpacing, height: 0)

            for index in frames.indices {
                var frame = frames[index]
                // X-position
                frame.origin.x = movingOrigin.x
                // Y-position
                switch alignment {
                case .top:
                    frame.origin.y = 0
                case .center:
                    frame.origin.y = (availableHeight - frame.height) / 2
                case .bottom:
                    frame.origin.y = availableHeight - frame.height
                case .firstTextBaseline, .lastTextBaseline:
                    fatalError("Not implemented.")
                }
                frames[index] = frame.roundedToScale(scale: screenScale)
                if nodes[index].isSpacer || (index < nodes.count - 1 && nodes[index + 1].isSpacer) {
                    movingOrigin.x += frame.width
                } else {
                    movingOrigin.x += frame.width + interItemSpacing
                }
                fittingSize = CGSize(
                    width: fittingSize.width + frame.width,
                    height: max(fittingSize.height, frame.height)
                )
            }

            return ContentGeometry(idealSize: fittingSize.roundedToScale(scale: screenScale), frames: frames)
        }
    }
}
