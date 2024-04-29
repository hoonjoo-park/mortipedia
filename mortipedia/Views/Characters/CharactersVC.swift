import UIKit
import FlexLayout
import PinLayout

class CharactersVC: UIViewController {
    let rootFlexContainer = UIView()
    let headerView = CharacterHeader()
    let characterVM = CharacterVM.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterVM.getCharacters()
        
        configureVC()
        configureUI()
    }
    
    
    private func configureVC() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isUserInteractionEnabled = false
        
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
