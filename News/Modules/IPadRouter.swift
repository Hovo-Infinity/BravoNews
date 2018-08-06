//
//  IPadRouter.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/6/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import UIKit

class IPadRouter: Router {
    func initModule() -> UIViewController {
        print("iPad")
        let vc: UISplitViewController = UIViewController.instantiateViewController()
        return vc
    }
}
