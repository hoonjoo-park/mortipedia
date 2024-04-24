import UIKit
import FlexLayout
import PinLayout

class CharactersVC: UIViewController {
    let rootFlexContainer = UIView()
    let headerView = CharacterHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureSubViews()
    }
    
    
    private func configureVC() {
        view.addSubview(rootFlexContainer)
        view.backgroundColor = Colors.background
    }
    
    
    private func configureSubViews() {
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(headerView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout()
    }
}
