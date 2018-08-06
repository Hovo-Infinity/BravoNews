//
//  IPhoneRouter.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/6/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import UIKit

class IPhoneRouter: Router {
    func initModule() -> UIViewController {
        print("iPhone")
        let vc: ViewController = UIViewController.instantiateViewController()
        return vc
    }
}
