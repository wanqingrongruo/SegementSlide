//
//  RecordSwitcherView.swift
//  Example
//
//  Created by roni on 2025/4/3.
//  Copyright © 2025 Jiar. All rights reserved.
//

import UIKit
import SegementSlide

private var reordDataSourceKey: Void?

public protocol SegementSlideAudioSwitcherViewDelegate: AnyObject {
    func segementSwitcherView(_ segementSlideSwitcherView: SegementSlideDefaultSwitcherView, didSelectAtIndex index: Int, animated: Bool)
}

class RecordSwitcherView: UIView {
    public private(set) var scrollView = UIScrollView()
    private var titleButtons: [UIButton] = []
    
    /// you should call `reloadData()` after set this property.
    open var defaultSelectedIndex: Int?
    
    public private(set) var selectedIndex: Int?
    public weak var delegate: SegementSlideAudioSwitcherViewDelegate?
    
    /// you must call `reloadData()` to make it work, after the assignment.
    public var config: SegementSlideDefaultSwitcherConfig = SegementSlideDefaultSwitcherConfig.shared
    
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
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = .clear
        
        
        backgroundColor = .white
        
        configButtons()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func configButtons() {
        // todo: - 创建 按钮
    }

    func reloadData() {
        // 刷新
    }
    
    func selectItem(at index: Int, animated: Bool) {
        
    }
}

extension RecordSwitcherView: SegementSlideSwitcherDelegate {
    
    public weak var ssDataSource: SegementSlideSwitcherDataSource? {
        get {
            let weakBox = objc_getAssociatedObject(self, &reordDataSourceKey) as? SegementSlideSwitcherDataSourceWeakBox
            return weakBox?.unbox
        }
        set {
            objc_setAssociatedObject(self, &reordDataSourceKey, SegementSlideSwitcherDataSourceWeakBox(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var ssDefaultSelectedIndex: Int? {
        get {
            return defaultSelectedIndex
        }
        set {
            defaultSelectedIndex = newValue
        }
    }
    
    public var ssSelectedIndex: Int? {
        return selectedIndex
    }
    
    public var ssScrollView: UIScrollView {
        return scrollView
    }
}
