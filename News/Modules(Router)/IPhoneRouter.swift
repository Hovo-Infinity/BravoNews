//
//  IPhoneRouter.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/6/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import UIKit

class IPhoneRouter: PresenterToRouterProtocol {
    func initModule() -> UIViewController {
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        let vc: ViewController = UIViewController.instantiateViewController()
        vc.presenter = presenter
        interactor.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = self
        return vc
    }
}
