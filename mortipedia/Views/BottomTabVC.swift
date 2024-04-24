import UIKit

class BottomTabVC: UITabBarController {
    let characterIcon = UIImage(named: "character")
    let episodeIcon = UIImage(named: "episode")
    let settingIcon = UIImage(named: "setting")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
        configureTabStyles()
    }
    
    private func configureTabs() {
        let charactersVC = CharactersVC()
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: characterIcon, selectedImage: characterIcon)
        
        let episodesVC = EpisodesVC()
        episodesVC.tabBarItem = UITabBarItem(title: "Episodes", image: episodeIcon, selectedImage: episodeIcon)
        
        let settingsVC = SettingsVC()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: settingIcon, selectedImage: settingIcon)
        
        viewControllers = [charactersVC, episodesVC, settingsVC].map { UINavigationController(rootViewController: $0) }
    }
    
    private func configureTabStyles() {
        tabBar.tintColor = Colors.text
        tabBar.unselectedItemTintColor = Colors.gray2
        tabBar.backgroundColor = Colors.gray4
    }
}
