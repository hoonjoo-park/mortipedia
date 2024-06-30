//
//  LoadingView.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 5/18/24.
//

import UIKit
import FlexLayout
import PinLayout

class LoadingView: UIView {
    let indicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicator.startAnimating()
        
        flex.backgroundColor(Colors.background).alignItems(.center).justifyContent(.center).define { flex in
            flex.addItem(indicator)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        pin.all()
        flex.layout()
    }
}
