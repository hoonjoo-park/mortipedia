//
//  LoadingVC.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 5/18/24.
//

import UIKit
import FlexLayout

class LoadingVC: UIViewController {
    let indicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        view.flex.backgroundColor(Colors.background).alignItems(.center).justifyContent(.center).define { flex in
            flex.addItem(indicator)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.pin.all()
        view.flex.layout()
    }
}
