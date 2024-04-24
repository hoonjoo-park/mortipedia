import UIKit

class EpisodesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.background
        navigationItem.title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
