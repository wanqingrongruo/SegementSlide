//
//  EmptySwitcherView.swift
//  Example
//
//  Created by roni on 2025/4/3.
//  Copyright © 2025 Jiar. All rights reserved.
//

import UIKit
import SegementSlide

class EmptySwitchDataSource: SegementSlideSwitcherDataSource {
    // 返回一个元素的数组，因为 childvc 数目时根据这个数组的 count来的
    var titles: [String] {
        return [""]
    }
    
    var height: CGFloat {
        return 0
    }
}

class EmptySwitcherView: UIView, SegementSlideSwitcherDelegate {
    var ssDataSource: SegementSlideSwitcherDataSource? = EmptySwitchDataSource()
    var ssDefaultSelectedIndex: Int? = nil
    var ssSelectedIndex: Int? = nil
    var ssScrollView: UIScrollView = UIScrollView()
    
    func reloadData() {
        
    }
    
    func selectItem(at index: Int, animated: Bool) {
        
    }
}
