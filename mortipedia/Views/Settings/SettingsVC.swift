import UIKit
import FlexLayout
import PinLayout

class SettingsVC: UIViewController {
    private let rootFlexContainer = UIView()
    private var settingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        configureUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexContainer.pin.all(view.safeAreaInsets)
        rootFlexContainer.flex.layout()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        // TODO: UITableView 세팅
    }
    
    
    private func configureUI() {
        self.settingsTableView = UITableView(frame: .zero)
        
        view.addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(settingsTableView)
        }
    }
}
