//
//  CharacterDetailVC.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 5/4/24.
//

import UIKit

class CharacterDetailVC: UIViewController {
    var characterId: Int!
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    init(characterId: Int) {
        self.characterId = characterId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
