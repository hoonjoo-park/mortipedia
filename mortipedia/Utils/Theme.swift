import Foundation

enum UserTheme: String {
    case system, light, dark
}

func saveTheme(_ theme: UserTheme) {
    UserDefaults.standard.setValue(theme, forKey: UserDefaultKeys.theme)
}

func getTheme() -> UserTheme {
    let themePreference = UserDefaults.standard.string(forKey: UserDefaultKeys.theme) ?? UserTheme.system.rawValue
    return UserTheme(rawValue: themePreference) ?? .system
}
