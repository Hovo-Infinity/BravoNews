//
//  BaseViewController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/25/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
        addTopTitleLabel()
        view.backgroundColor = .random
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackgroundColor), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    // for change background color after retunr from background
    @objc
    func changeBackgroundColor() {
        view.backgroundColor = .random
    }
    
    // button at the top left on the screen
    private func addCloseButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 44, height: 44))
        button.setBackgroundImage(UIImage(named: "ic_close"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func addTopTitleLabel() {
        let titleLabel = UILabel(frame: CGRect(x: 52, y: 20, width: view.frame.width - 104, height: 44))
        titleLabel.numberOfLines = 0
        titleLabel.text = self.title
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    @objc
    func back() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionReveal
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }


}
