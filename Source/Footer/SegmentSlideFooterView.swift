//
//  SegmentSlideFooterView.swift
//  JXSegmentedView
//
//  Created by roni on 2025/4/2.
//

import UIKit

public class SegmentSlideFooterView: UIView {
    
    private weak var lastFooterView: UIView?
    private weak var contentView: SegementSlideContentView?
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
    }
    
    internal func config(_ footerView: UIView?, contentView: SegementSlideContentView) {
        guard footerView != lastFooterView else {
            return
        }
        if let lastHeaderView = lastFooterView {
            lastHeaderView.removeAllConstraints()
            lastHeaderView.removeFromSuperview()
        }
        guard let footerView = footerView else {
            return
        }
        self.contentView = contentView
        addSubview(footerView)
        footerView.constraintToSuperview()
        lastFooterView = footerView
    }
}
