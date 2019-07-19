//
//  SegementSlideSwitcherConfig.swift
//  SegementSlide
//
//  Created by Jiar on 2019/1/16.
//  Copyright © 2019 Jiar. All rights reserved.
//

import UIKit

public struct SegementSlideSwitcherConfig {
    
    public static let shared = SegementSlideSwitcherConfig()
    
    public var type: SwitcherType
    public var horizontalMargin: CGFloat
    public var horizontalSpace: CGFloat
    public var normalTitleFont: UIFont
    public var selectedTitleFont: UIFont
    public var normalTitleColor: UIColor
    public var selectedTitleColor: UIColor
    public var indicatorWidth: CGFloat
    public var indicatorHeight: CGFloat
    public var indicatorColor: UIColor
    public var badgeHeightForPointType: CGFloat
    public var badgeHeightForCountType: CGFloat
    public var badgeHeightForCustomType: CGFloat
    public var badgeFontForCountType: UIFont
    public var badgeBackgroundColor: UIColor
    
    public init(type: SwitcherType = .segement,
                horizontalMargin: CGFloat = 20,
                horizontalSpace: CGFloat = 26,
                normalTitleFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium),
                selectedTitleFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold),
                normalTitleColor: UIColor = UIColor.gray,
                selectedTitleColor: UIColor = UIColor.darkGray,
                indicatorWidth: CGFloat = 16,
                indicatorHeight: CGFloat = 2,
                indicatorColor: UIColor = UIColor.darkGray,
                badgeHeightForPointType: CGFloat = 9,
                badgeHeightForCountType: CGFloat = 15,
                badgeHeightForCustomType: CGFloat = 12,
                badgeFontForCountType: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular),
                badgeBackgroundColor: UIColor = UIColor.red) {
        self.type = type
        self.horizontalMargin = horizontalMargin
        self.horizontalSpace = horizontalSpace
        self.normalTitleFont = normalTitleFont
        self.selectedTitleFont = selectedTitleFont
        self.normalTitleColor = normalTitleColor
        self.selectedTitleColor = selectedTitleColor
        self.indicatorWidth = indicatorWidth
        self.indicatorHeight = indicatorHeight
        self.indicatorColor = indicatorColor
        self.badgeHeightForPointType = badgeHeightForPointType
        self.badgeHeightForCountType = badgeHeightForCountType
        self.badgeHeightForCustomType = badgeHeightForCustomType
        self.badgeFontForCountType = badgeFontForCountType
        self.badgeBackgroundColor = badgeBackgroundColor
    }
    
}
