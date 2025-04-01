//
//  CurvedSectionLayout.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/10/2.
//

import SwiftUI
/// A custom layout that arranges subviews in a curved section.
struct CurvedSectionLayout: Layout {
    /// The corner radius of the curved sections.
    var cornerRadius: CGFloat = 5
    /// The spacing between sections.
    var spacing: CGFloat = 20
    /// Calculates the size that best fits the proposed size.
    /// - Parameters:
    ///   - proposal: The proposed size for the layout.
    ///   - subviews: The subviews to be arranged.
    ///   - cache: A cache to store intermediate results.
    /// - Returns: The size that best fits the proposed size.
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            let totalSpacing = spacing * CGFloat(subviews.count - 1)
            let availableHeight = (proposal.height ?? .zero) - totalSpacing
        _ = availableHeight / CGFloat(subviews.count)
            
            return CGSize(width: proposal.width ?? .zero, height: proposal.height ?? .zero)
    }
    /// Places the subviews within the bounds of the layout.
    /// - Parameters:
    ///   - bounds: The bounds of the layout.
    ///   - proposal: The proposed size for the layout.
    ///   - subviews: The subviews to be arranged.
    ///   - cache: A cache to store intermediate results.
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let totalSpacing = spacing * CGFloat(subviews.count - 1)
        let availableHeight = bounds.height - totalSpacing
        let sectionHeight = availableHeight / CGFloat(subviews.count)
        
        var y = bounds.minY
        
        for subview in subviews {
            let subviewSize = CGSize(width: bounds.width, height: sectionHeight)
            let point = CGPoint(x: bounds.minX, y: y)
            
            subview.place(at: point, proposal: ProposedViewSize(subviewSize))
            
            y += sectionHeight + spacing
        }
    }
}


