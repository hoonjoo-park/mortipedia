import UIKit
import FlexLayout

class CharacterHeader: UIView {
    let rootFlexContainer = UIView()
    let title = MortiLabel(fontSize: 16, weight: .bold, color: Colors.text)
    let profileImageView = UIImageView()
    let searchButton = UIButton()
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
        
        searchIcon.tintColor = Colors.text
        searchButton.addTarget(self, action: #selector(handlePressSearchButton), for: .touchUpInside)
        
        profileImageView.image = profileImage
        
        title.text = "Hello, \(username)!"
    }
    
    
    private func configureFlexLayout() {
        rootFlexContainer.flex.direction(.row).paddingVertical(20).paddingHorizontal(25).define { flex in
            flex.addItem().direction(.row).alignItems(.center).gap(15).grow(1).define { flex in
                flex.addItem().size(45).justifyContent(.center).alignItems(.center).cornerRadius(22.5).backgroundColor(Colors.accent).define { flex in
                    flex.addItem(profileImageView).width(30).aspectRatio(of: profileImageView)
                }
                flex.addItem(title)
            }
            
            flex.addItem(searchButton).size(45).justifyContent(.center).alignItems(.center).define { flex in
                flex.addItem(searchIcon).size(24).aspectRatio(of: searchIcon)
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.flex.layout()
    }
    
    
    @objc private func handlePressSearchButton() {}
}
