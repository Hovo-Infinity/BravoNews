//
//  NewsPresenter.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/7/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import Foundation

class NewsPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresentorToInterectorProtocol?
    var router: PresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchNews()
    }
}

extension NewsPresenter: InterectorToPresenterProtocol {
    func newsFetchEnded(news: NewsList) {
        view?.showNews(news)
    }
    
    func newsFetchFailed(error: Error) {
        view?.showError(error)
    }
}
