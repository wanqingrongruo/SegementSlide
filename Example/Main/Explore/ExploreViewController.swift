//
//  ExploreViewController.swift
//  Example
//
//  Created by Jiar on 2018/12/12.
//  Copyright © 2018 Jiar. All rights reserved.
//

import UIKit
import SegementSlide

class ExploreViewController: BaseSegementSlideViewController {

    private var badges: [Int: BadgeType] = [:]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Explore"
        tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "tab_explore")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_explore_sel")?.withRenderingMode(.alwaysOriginal))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var headerView: UIView? {
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "bg_working.png")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
        return headerView
    }
    
    override var switcherConfig: SegementSlideSwitcherConfig {
        let config = SegementSlideSwitcherConfig(type: .segement,
                                                 horizontalMargin: 11,
                                                 horizontalSpace: 24,
                                                 normalTitleFont: UIFont.systemFont(ofSize: 14),
                                                 selectedTitleFont: UIFont.systemFont(ofSize: 20, weight: .semibold),
                                                 normalTitleColor: .black,
                                                 selectedTitleColor: .red,
                                                 indicatorWidth: 18,
                                                 indicatorHeight: 4,
                                                 indicatorColor: .yellow,
                                                 badgeHeightForCustomType: 12,
                                                 badgeFontForCountType: UIFont.systemFont(ofSize: 7),
                                                 badgeBackgroundColor: .purple)
        return config
    }
    
    override var titlesInSwitcher: [BaseTitleModel] {
        return [BaseTitleModel(title: "全部"), BaseTitleModel(title: "打卡"), BaseTitleModel(title: "活动"), BaseTitleModel(title: "讨论"), BaseTitleModel(title: "调查"), BaseTitleModel(title: "通知")]//DataManager.shared.exploreLanguageTitles
    }

    override func showBadgeInSwitcher(at index: Int) -> BadgeType {
        if let badge = badges[index] {
            return badge
        } else {
            let badge = index == 1 ? BadgeType.richTextNewMark : .none
            badges[index] = badge
            return badge
        }
    }

//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }

//    override func scrollViewDidScroll(_ scrollView: UIScrollView, isParent: Bool) {
//        guard !isParent else { return }
//        guard let navigationController = navigationController else { return }
//        let translationY = -scrollView.panGestureRecognizer.translation(in: scrollView).y
//        if translationY > 0 {
//            guard !navigationController.isNavigationBarHidden else { return }
//            navigationController.setNavigationBarHidden(true, animated: true)
//            headerView?.isHidden = true
//        } else {
////            guard !scrollView.isTracking else { return }
//            guard navigationController.isNavigationBarHidden else { return }
//            navigationController.setNavigationBarHidden(false, animated: true)
//            headerView?.isHidden = false
//        }
//    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        let viewController = ContentViewController()
        viewController.refreshHandler = { [weak self] in
            guard let self = self else { return }
//            self.badges[index] = (index % 2) == 0 ? BadgeType.richTextNewMark : .none //BadgeType.random
//            self.reloadBadgeInSwitcher()
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        scrollToSlide(at: 0, animated: false)
    }

}
