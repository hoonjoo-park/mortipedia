import UIKit

class EpisodesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
        navigationItem.title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
