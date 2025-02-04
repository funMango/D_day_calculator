//
//  GestureExtension.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/4/25.
//

import Foundation
import SwiftUI

// MARK: - 뒤로가기
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
