//
//  InterectorToPresenterProtocol.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/6/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import Foundation

protocol InterectorToPresenterProtocol {
    func newsFetchEnded(news: NewsList)
    func newsFetchFailed(error: Error)
}
