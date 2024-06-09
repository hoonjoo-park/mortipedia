import UIKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

class EpisodesVC: UIViewController {
    private let episodeVM = EpisodeVM.shared
    private let disposeBag = DisposeBag()
    
    private let rootFlexContainer = UIView()
    private var episodesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        bindViewModel()
        configureUI()
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
    
    
    private func bindViewModel() {
        self.episodesTableView = UITableView(frame: .zero)
        
        episodesTableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.reuseId)
        episodesTableView.rowHeight = 58
        episodesTableView.separatorStyle = .none
        
        episodeVM.episodes.bind(to: episodesTableView.rx.items(cellIdentifier: EpisodesTableViewCell.reuseId, cellType: EpisodesTableViewCell.self)) { row, episode, cell in
            guard let episode = episode else { return }
            
            cell.setCell(episode: episode)
        }.disposed(by: disposeBag)
    }
    
    
    private func configureUI() {
        view.addSubview(rootFlexContainer)
        view.backgroundColor = Colors.background
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(episodesTableView).grow(1)
        }
    }
}
