//
//  BaseSegmentSlideAudioViewController.swift
//  Example
//
//  Created by roni on 2025/4/3.
//  Copyright © 2025 Jiar. All rights reserved.
//

import UIKit
import SegementSlide

@objc
public protocol SegementSlideAudioContentScrollViewDelegate: SegementSlideContentScrollViewDelegate {
    @objc optional func reloadAll()
}

class BaseSegmentSlideAudioViewController: SegementSlideViewController {
    
    private lazy var audioSwitcherView: RecordSwitcherView = {
        let view = RecordSwitcherView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func segementSlideHeaderView() -> UIView? {
        // 重写 header
        return nil
    }
    
    override func segementSlideFooterView() -> UIView? {
        // 重写 footer
        return nil
    }
    
    override func segementSlideSwitcherView() -> any SegementSlideSwitcherDelegate {
        // 重写 switchview
        // 不显示时返回一个无高度的 view， 否则返回 audioSwitcherView
        return EmptySwitcherView()
    }
    
    override func segementSlideContentViewController(at index: Int) -> (any SegementSlideContentScrollViewDelegate)? {
        // 根据 index 返回指定的 vc
        return nil
    }
}

extension BaseSegmentSlideAudioViewController: SegementSlideAudioSwitcherViewDelegate {
    func segementSwitcherView(_ segementSlideSwitcherView: SegementSlideDefaultSwitcherView, didSelectAtIndex index: Int, animated: Bool) {
        if contentView.selectedIndex != index {
            contentView.selectItem(at: index, animated: animated)
        }
    }
}
