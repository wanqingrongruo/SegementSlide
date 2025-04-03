//
//  ExploreViewController.swift
//  Example
//
//  Created by Jiar on 2018/12/12.
//  Copyright © 2018 Jiar. All rights reserved.
//

import UIKit
import SegementSlide
import MJRefresh

class ExploreViewController: BaseSegementSlideDefaultViewController {

    private var badges: [Int: BadgeType] = [:]
    private var vc1: ContentViewController?
    private var vc2: ContentViewController?
    private var vc3: ContentViewController?
    private var vc4: ContentViewController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Explore"
        tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "tab_explore")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_explore_sel")?.withRenderingMode(.alwaysOriginal))
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "bg_working.png")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
        headerView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        headerView.addGestureRecognizer(tap)
        return headerView
    }
    
    @objc func didTap() {
        print("========did tap")
    }
    
    override var switcherConfig: SegementSlideDefaultSwitcherConfig {
        var config = super.switcherConfig
        config.type = .segement
        return config
    }
    
    override var titlesInSwitcher: [String] {
        return DataManager.shared.exploreLanguageTitles
    }
    
    override func showBadgeInSwitcher(at index: Int) -> BadgeType {
        if let badge = badges[index] {
            return badge
        } else {
            let badge = BadgeType.random
            badges[index] = badge
            return badge
        }
    }
    
    override func segementSlideFooterView() -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.backgroundColor = .red
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            if let vc1 = vc1 {
                return vc1
            } else {
                let vc = ContentViewController()
                vc1 = vc
                return vc
            }
        case 1:
            if let vc1 = vc2 {
                return vc1
            } else {
                let vc = ContentViewController()
                vc2 = vc
                return vc
            }
        case 2:
            if let vc1 = vc3 {
                return vc1
            } else {
                let vc = ContentViewController()
                vc3 = vc
                return vc
            }
        case 3:
            if let vc1 = vc4 {
                return vc1
            } else {
                let vc = ContentViewController()
                vc4 = vc
                return vc
            }
        default:
            return ContentViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshAction))
        refreshHeader?.lastUpdatedTimeLabel.isHidden = true
        scrollView.mj_header = refreshHeader
        defaultSelectedIndex = 0
        reloadData()
    }
    
    @objc
    private func refreshAction() {
        DispatchQueue.global().asyncAfter(deadline: .now()+Double.random(in: 0..<2)) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                guard let currentIndex = self.currentIndex else {
                    return
                }
                self.badges[currentIndex] = BadgeType.random
                self.reloadBadgeInSwitcher()
                self.scrollView.mj_header.endRefreshing()
            }
        }
    }

}
