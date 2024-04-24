import UIKit
import FlexLayout
import PinLayout

class CharacterHeader: UIView {
    let rootFlexContainer = UIView()
    let title = MortiLabel(fontSize: 16, weight: .bold, color: Colors.text)
    let profileImageView = UIImageView()
    let searchButton = UIButton(type: .custom)
    let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rootFlexContainer)
        
        configureUI()
        configureFlexLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let selectedProfile = getProfile()
        let profileImage = selectedProfile == UserProfile.rick ? UIImage(named: "rick-avatar") : UIImage(named: "morty-avatar")
        let username = selectedProfile == UserProfile.rick ? "Rick" : "Morty"
        
        profileImageView.image = profileImage
        searchIcon.tintColor = Colors.text
        title.text = "Hello, \(username)!"
    }
    
    private func configureFlexLayout() {
        rootFlexContainer.flex.direction(.row).paddingVertical(20).paddingHorizontal(25).define { flex in
            flex.addItem().direction(.row).gap(15).grow(1).define { flex in
                flex.addItem(profileImageView).width(45).aspectRatio(of: profileImageView)
                flex.addItem(title)
            }
            
            flex.addItem(searchButton).width(45).justifyContent(.center).alignItems(.center).define { flex in
                flex.addItem(searchIcon).size(24).aspectRatio(of: searchIcon)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.topLeft().width(100%).marginTop(safeAreaInsets.top)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}
