import UIKit
import FlexLayout
import RxSwift

class CharacterHeader: UIView {
    let characterVM = CharacterVM.shared
    let disposeBag = DisposeBag()
    
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
                
        configureUI()
        configureFlexLayout()
        bindSearchMode()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        let selectedProfile = getProfile()
        let profileImage = selectedProfile == UserProfile.rick ? UIImage(named: "rick-avatar") : UIImage(named: "morty-avatar")
        let username = selectedProfile == UserProfile.rick ? "Rick" : "Morty"
        
        searchIcon.tintColor = Colors.text
        searchButton.addTarget(self, action: #selector(toggleSearchMode), for: .touchUpInside)
        
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
        
        cancelButton.addTarget(self, action: #selector(toggleSearchMode), for: .touchUpInside)
    }
    
    
    private func configureFlexLayout() {
        self.flex.paddingVertical(10).paddingHorizontal(25).define { flex in
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
    
    
    private func bindSearchMode() {
        characterVM.isSearchMode.subscribe(onNext: { [weak self] isSearchMode in
            guard let self = self else { return }
            
            if isSearchMode {
                self.animateHeader(toHide: self.headerContainer, toShow: self.searchContainer)
            } else {
                self.animateHeader(toHide: self.searchContainer, toShow: self.headerContainer)
            }
        }).disposed(by: disposeBag)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flex.layout()
    }
    
    
    @objc private func toggleSearchMode() {
        characterVM.toggleSearchMode()
    }
    
    
    private func animateHeader(toHide: UIView, toShow: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: {
            toHide.alpha = 0
        }, completion: { _ in
            toShow.alpha = 0
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut], animations: {
                toShow.alpha = 1
            })
        })
    }
}
