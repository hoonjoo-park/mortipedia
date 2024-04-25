import UIKit
import FlexLayout
import PinLayout

class CharactersVC: UIViewController {
    let rootFlexContainer = UIView()
    let headerView = CharacterHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
    }
    
    
    private func configureVC() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(rootFlexContainer)
        view.backgroundColor = Colors.background
    }
    
    
    private func configureUI() {
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(headerView)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexContainer.pin.all(view.safeAreaInsets)
        rootFlexContainer.flex.layout()
    }
}
