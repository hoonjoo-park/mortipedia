//
//  NavigationHelper.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 5/5/24.
//

import Foundation
import UIKit

public class NavigationConfigurator {
    public static let shared = NavigationConfigurator()
    
    private let arrowBackImage = UIImage(named: "arrow-back") ?? UIImage(systemName: "chevron.backward")
    
    private init() {}
    
    public func setNavigationBarBackButton() {
        UINavigationBar.appearance().backIndicatorImage = arrowBackImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = arrowBackImage
        UINavigationBar.appearance().tintColor = Colors.text
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
    }
}
