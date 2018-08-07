//
//  PresenterToViewProtocol.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/7/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import Foundation

protocol PresenterToViewProtocol {
    func showNews(_ news: NewsList)
    func showError(_ error: Error)
}
