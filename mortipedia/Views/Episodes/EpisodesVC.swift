import UIKit

class EpisodesVC: UIViewController {
    private let episodeVM = EpisodeVM.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
        navigationItem.title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        episodeVM.getEpisodes()
    }
}
