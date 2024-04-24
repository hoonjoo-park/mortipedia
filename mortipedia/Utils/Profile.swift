import Foundation

enum UserProfile: String {
    case rick, morty
}

func getProfile() -> UserProfile {
    let userProfile = UserDefaults.standard.string(forKey: UserDefaultKeys.profile) ?? UserProfile.rick.rawValue
    return UserProfile(rawValue: userProfile) ?? .rick
}

func changeUserProfile(_ newProfile: UserProfile) {
    UserDefaults.standard.set(newProfile, forKey: UserDefaultKeys.profile)
}
