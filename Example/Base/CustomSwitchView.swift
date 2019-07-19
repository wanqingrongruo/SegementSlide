//
//  CustomSwitchView.swift
//  Example
//
//  Created by roni on 2019/7/15.
//  Copyright © 2019 Jiar. All rights reserved.
//

import Foundation
import UIKit
import SegementSlide

class CustomSwitchView: UIView, SlideSwitcherViewProtocol {

    private let scrollView = UIScrollView()
    private let indicatorView = UIView()
    private var titleButtons: [UIView] = []

    public var gestureRecognizersInScrollView: [UIGestureRecognizer]? {
        return scrollView.gestureRecognizers
    }

    private var initSelectedIndex: Int?
    public var selectedIndex: Int? {
        get {
            return initSelectedIndex
        }

        set {
            initSelectedIndex = newValue
        }
    }

    private weak var innerDelegate: SegementSlideSwitcherViewDelegate?
    public var delegate: SegementSlideSwitcherViewDelegate? {
        get {
            return innerDelegate
        }
        set {
            innerDelegate = newValue
        }
    }

    private var innerConfig: SegementSlideSwitcherConfig = SegementSlideSwitcherConfig.shared
    public var config: SegementSlideSwitcherConfig {
        get {
            return innerConfig
        }

        set {
            innerConfig = newValue
        }
    }

    public override var intrinsicContentSize: CGSize {
        return scrollView.contentSize
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(scrollView)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.constraintToSuperview()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        backgroundColor = .white
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
//        layoutTitleButtons()
//        reloadBadges()
//        recoverInitSelectedIndex()
//        updateSelectedIndex()
    }

    func reloadData() {
        //
    }

    func reloadBadges() {
        //
    }

    func selectSwitcher(at index: Int, animated: Bool) {
        //
    }
}
