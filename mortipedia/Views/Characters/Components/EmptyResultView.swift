//
//  EmptyResultView.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 5/4/24.
//

import UIKit
import FlexLayout

class EmptyResultView: UIView {
    private let messageLabel = MortyLabel(fontSize: 20, weight: .bold, color: Colors.gray2)
    
    init(message: String) {
        super.init(frame: .zero)
        
        messageLabel.text = message
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        self.flex.grow(1).alignItems(.center).justifyContent(.center).define { flex in
            flex.addItem(messageLabel)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flex.layout()
    }
}
