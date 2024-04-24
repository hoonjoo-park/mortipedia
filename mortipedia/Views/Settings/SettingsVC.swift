import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.background
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
