import UIKit
import FlexLayout

class CharacterHeader: UIView {
    let rootFlexContainer = UIView()
    let headerContainer = UIView()
    let title = MortiLabel(fontSize: 16, weight: .bold, color: Colors.text)
    let profileImageView = UIImageView()
    let searchButton = UIButton()
    let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    let searchContainer = UIView()
    let searchTextField = UITextField()
    let cancelButton = UIButton()
    let textFieldIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    
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
        
        searchContainer.alpha = 0
        searchTextField.placeholder = "Enter character name here"
        searchTextField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        searchTextField.textColor = Colors.text
        textFieldIcon.tintColor = Colors.text
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(Colors.primary, for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        cancelButton.addTarget(self, action: #selector(handlePressCancelButton), for: .touchUpInside)
    }
    
    
    private func configureFlexLayout() {
        rootFlexContainer.flex.paddingVertical(10).paddingHorizontal(25).define { flex in
            flex.addItem(headerContainer).direction(.row).alignItems(.center).define { flex in
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
            
            flex.addItem(searchContainer).direction(.row).gap(15).position(.absolute).horizontally(0).paddingVertical(10).paddingHorizontal(25).define { flex in
                
                flex.addItem().direction(.row).alignItems(.center).grow(1).cornerRadius(12).padding(10).gap(12).backgroundColor(Colors.gray1).define { flex in
                    flex.addItem(textFieldIcon)
                    flex.addItem(searchTextField)
                }
                flex.addItem(cancelButton).padding(5)
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.flex.layout()
    }
    
    
    @objc private func handlePressSearchButton() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: {
            self.headerContainer.alpha = 0
        }, completion: { _ in
            self.searchContainer.alpha = 0
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: {
                self.searchContainer.alpha = 1
            })
        })
    }
    
    @objc private func handlePressCancelButton() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: {
            self.searchContainer.alpha = 0
        }, completion: { _ in
            self.headerContainer.alpha = 0
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: {
                self.headerContainer.alpha = 1
            })
        })
    }
}
