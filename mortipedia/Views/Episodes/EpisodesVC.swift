import UIKit

class EpisodesVC: UIViewController {
    private let episodeVM = EpisodeVM.shared
    
    private let rootFlexContainer = UIView()
    private var episodesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexContainer.pin.all(view.safeAreaInsets)
        rootFlexContainer.flex.layout()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
        navigationItem.title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        episodeVM.getEpisodes()
    }
    
    
    private func configureUI() {
        view.addSubview(rootFlexContainer)
        view.backgroundColor = Colors.background
        
        rootFlexContainer.flex.define { flex in
            flex.addItem()
        }
    }
}
