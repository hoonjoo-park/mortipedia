import Foundation
import UIKit

enum UserTheme: String {
    case system, light, dark
}


func changeTheme(_ theme: UserTheme) {
    UserDefaults.standard.set(theme, forKey: UserDefaultKeys.theme)
    
    updateInterfaceStyle()
}


func getTheme() -> UserTheme {
    let themePreference = UserDefaults.standard.string(forKey: UserDefaultKeys.theme) ?? UserTheme.system.rawValue
    return UserTheme(rawValue: themePreference) ?? .system
}


func updateInterfaceStyle() {
    guard let window = UIApplication.shared.windows.first else { return }
    
    let userTheme = getTheme()
    
    switch userTheme {
    case .light:
        window.overrideUserInterfaceStyle = .light
    case .dark:
        window.overrideUserInterfaceStyle = .dark
    case .system:
        window.overrideUserInterfaceStyle = .unspecified
    }
}
