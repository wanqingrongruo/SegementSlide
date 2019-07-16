//
//  SegementSlideSwitcherView.swift
//  SegementSlide
//
//  Created by Jiar on 2018/12/7.
//  Copyright © 2018 Jiar. All rights reserved.
//

import UIKit

public enum SwitcherType {
    case tab
    case segement
}

protocol SwitcherTitleProtocol {
    var currentTitle: String { get }
}

public struct BaseTitleModel: SwitcherTitleProtocol {
    private let title: String
    public init (title: String) {
        self.title = title
    }

    public var currentTitle: String {
        return title
    }
}

public protocol SegementSlideSwitcherViewDelegate: class {
    var titlesInSegementSlideSwitcherView: [BaseTitleModel] { get }
    
    func segementSwitcherView(_ segementSlideSwitcherView: SegementSlideSwitcherView, didSelectAtIndex index: Int, animated: Bool)
    func segementSwitcherView(_ segementSlideSwitcherView: SegementSlideSwitcherView, showBadgeAtIndex index: Int) -> BadgeType
    func segementButtonView(_ segementSlideSwitcherView: SegementSlideSwitcherView, showBadgeAtIndex index: Int) -> UIView
}

extension SegementSlideContentDelegate {
    public func segementButtonView(_ segementSlideSwitcherView: SegementSlideSwitcherView, showBadgeAtIndex index: Int) -> UIView {
        return UIButton(type: .custom)
    }
}

public protocol SlideSwitcherViewProtocol: UIView {
    var selectedIndex: Int? { get set }
    var gestureRecognizersInScrollView: [UIGestureRecognizer]? { get }
    var delegate: SegementSlideSwitcherViewDelegate? { get set }
    /// you must call `reloadData()` to make it work, after the assignment.
    var config: SegementSlideSwitcherConfig { get set }

    func reloadData()
    func reloadBadges()
    func selectSwitcher(at index: Int, animated: Bool)
}

public class SegementSlideSwitcherView: UIView, SlideSwitcherViewProtocol {
    
    private let scrollView = UIScrollView()
    private let indicatorView = UIView()
    private var titleButtons: [UIButton] = []

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
        layoutTitleButtons()
        reloadBadges()
        recoverInitSelectedIndex()
        updateSelectedIndex()
    }
    
    /// relayout subViews
    ///
    /// you should call `selectSwitcher(at index: Int, animated: Bool)` after call the method.
    /// otherwise, none of them will be selected.
    /// However, if an item was previously selected, it will be reSelected.
    public func reloadData() {
        for titleButton in titleButtons {
            titleButton.removeFromSuperview()
            titleButton.frame = .zero
        }
        titleButtons.removeAll()
        indicatorView.removeFromSuperview()
        indicatorView.frame = .zero
        scrollView.isScrollEnabled = innerConfig.type == .segement
        innerConfig = config
        guard let titleModels = delegate?.titlesInSegementSlideSwitcherView else { return }
        guard !titleModels.isEmpty else { return }
        for (index, model) in titleModels.enumerated() {
            let button = UIButton(type: .custom)
            button.clipsToBounds = false
            button.titleLabel?.font = innerConfig.normalTitleFont
            button.backgroundColor = .clear
            button.setTitle(model.currentTitle, for: .normal)
            button.tag = index
            button.setTitleColor(innerConfig.normalTitleColor, for: .normal)
            button.addTarget(self, action: #selector(didClickTitleButton), for: .touchUpInside)
            scrollView.addSubview(button)
            titleButtons.append(button)
        }
        guard !titleButtons.isEmpty else { return }
        scrollView.addSubview(indicatorView)
        indicatorView.layer.masksToBounds = true
        indicatorView.layer.cornerRadius = innerConfig.indicatorHeight/2
        indicatorView.backgroundColor = innerConfig.indicatorColor
        layoutTitleButtons()
        reloadBadges()
        updateSelectedIndex()
    }
    
    /// reload all badges in `SegementSlideSwitcherView`
    public func reloadBadges() {
        for (index, titleButton) in titleButtons.enumerated() {
            guard let type = delegate?.segementSwitcherView(self, showBadgeAtIndex: index) else {
                titleButton.badge.type = .none
                continue
            }
            titleButton.badge.type = type
            if case .none = type {
                continue
            }
            let titleLabelText = titleButton.titleLabel?.text ?? ""
            let width: CGFloat
            if selectedIndex == index {
                width = titleLabelText.boundingWidth(with: innerConfig.selectedTitleFont)
            } else {
                width = titleLabelText.boundingWidth(with: innerConfig.normalTitleFont)
            }
            let height = titleButton.titleLabel?.font.lineHeight ?? titleButton.bounds.height
            switch type {
            case .none:
                break
            case .point:
                titleButton.badge.height = innerConfig.badgeHeightForPointType
                titleButton.badge.offset = CGPoint(x: width/2+titleButton.badge.height/2, y: -height/2)
            case .count:
                titleButton.badge.font = innerConfig.badgeFontForCountType
                titleButton.badge.height = innerConfig.badgeHeightForCountType
                titleButton.badge.offset = CGPoint(x: width/2+titleButton.badge.height/2, y: -height/2)
            case .custom:
                titleButton.badge.height = innerConfig.badgeHeightForCustomType
                titleButton.badge.offset = CGPoint(x: width/2+titleButton.badge.height/2, y: -height/2)
            }
        }
    }
    
    /// select one item by index
    public func selectSwitcher(at index: Int, animated: Bool) {
        updateSelectedButton(at: index, animated: animated)
    }
    
}

extension SegementSlideSwitcherView {
    
    private func recoverInitSelectedIndex() {
        guard let initSelectedIndex = initSelectedIndex else { return }
        self.initSelectedIndex = nil
        updateSelectedButton(at: initSelectedIndex, animated: false)
    }
    
    private func updateSelectedIndex() {
        guard let selectedIndex = selectedIndex else { return }
        updateSelectedButton(at: selectedIndex, animated: false)
    }
    
    private func layoutTitleButtons() {
        guard scrollView.frame != .zero else { return }
        guard !titleButtons.isEmpty else {
            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)
            return
        }
        var offsetX = innerConfig.horizontalMargin
        for titleButton in titleButtons {
            let buttonWidth: CGFloat
            switch innerConfig.type {
            case .tab:
                buttonWidth = (bounds.width-innerConfig.horizontalMargin*2)/CGFloat(titleButtons.count)
            case .segement:
                let title = titleButton.title(for: .normal) ?? ""
                let normalButtonWidth = title.boundingWidth(with: innerConfig.normalTitleFont)
                let selectedButtonWidth = title.boundingWidth(with: innerConfig.selectedTitleFont)
                buttonWidth = selectedButtonWidth > normalButtonWidth ? selectedButtonWidth : normalButtonWidth
            }
            titleButton.frame = CGRect(x: offsetX, y: 0, width: buttonWidth, height: scrollView.bounds.height)
            switch innerConfig.type {
            case .tab:
                offsetX += buttonWidth
            case .segement:
                offsetX += buttonWidth+innerConfig.horizontalSpace
            }
        }
        switch innerConfig.type {
        case .tab:
            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height)
        case .segement:
            scrollView.contentSize = CGSize(width: offsetX-innerConfig.horizontalSpace+innerConfig.horizontalMargin, height: bounds.height)
        }
    }
    
    private func updateSelectedButton(at index: Int, animated: Bool) {
        guard scrollView.frame != .zero else {
            initSelectedIndex = index
            return
        }
        guard titleButtons.count != 0 else { return }
        if let selectedIndex = selectedIndex, selectedIndex >= 0, selectedIndex < titleButtons.count {
            let titleButton = titleButtons[selectedIndex]
            titleButton.setTitleColor(innerConfig.normalTitleColor, for: .normal)
            titleButton.titleLabel?.font = innerConfig.normalTitleFont
        }
        guard index >= 0, index < titleButtons.count else { return }
        let titleButton = titleButtons[index]
        titleButton.setTitleColor(innerConfig.selectedTitleColor, for: .normal)
        titleButton.titleLabel?.font = innerConfig.selectedTitleFont
        if animated, indicatorView.frame != .zero {
            UIView.animate(withDuration: 0.25) {
                self.indicatorView.frame = CGRect(x: titleButton.frame.origin.x+(titleButton.bounds.width-self.innerConfig.indicatorWidth)/2, y: self.frame.height-self.innerConfig.indicatorHeight, width: self.innerConfig.indicatorWidth, height: self.innerConfig.indicatorHeight)
            }
        } else {
            indicatorView.frame = CGRect(x: titleButton.frame.origin.x+(titleButton.bounds.width-innerConfig.indicatorWidth)/2, y: frame.height-innerConfig.indicatorHeight, width: innerConfig.indicatorWidth, height: innerConfig.indicatorHeight)
        }
        if case .segement = innerConfig.type {
            var offsetX = titleButton.frame.origin.x-(scrollView.bounds.width-titleButton.bounds.width)/2
            if offsetX < 0 {
                offsetX = 0
            } else if (offsetX+scrollView.bounds.width) > scrollView.contentSize.width {
                offsetX = scrollView.contentSize.width-scrollView.bounds.width
            }
            if scrollView.contentSize.width > scrollView.bounds.width {
                scrollView.setContentOffset(CGPoint(x: offsetX, y: scrollView.contentOffset.y), animated: animated)
            }
        }
        guard index != selectedIndex else { return }
        selectedIndex = index
        delegate?.segementSwitcherView(self, didSelectAtIndex: index, animated: animated)
    }
    
    @objc private func didClickTitleButton(_ button: UIButton) {
        selectSwitcher(at: button.tag, animated: true)
    }
    
}
