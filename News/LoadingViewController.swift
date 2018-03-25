//
//  LoadingViewController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.startAnimating()
        view.backgroundColor = .lightGray
        view.addSubview(indicator)
    }
    
    override func viewDidLayoutSubviews() {
        indicator.center = view.center
    }

}
