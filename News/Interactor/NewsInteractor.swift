//
//  NewsInteractor.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/7/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import Foundation

class NewsInteractor: PresentorToInterectorProtocol {
    var presenter: InterectorToPresenterProtocol?
    func fetchNews() {
        let requestController = RequestController(url: URL(string: "https://www.helix.am/temp/json.php"))
        requestController.comletion = {[unowned self] (response, data) in
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                do {
                    News.clearDatabase()
                    let newsList = try JSONDecoder().decode(NewsList.self, from: data!)
                    self.presenter?.newsFetchEnded(news: newsList)
                } catch {
                    self.presenter?.newsFetchFailed(error: error)
                }
            }
            //            let json = try! JSON(data: data!)
            //            for index in 0..<json["metadata"].arrayValue.count  {
            //                let metaJson: JSON = json["metadata"].arrayValue[index]
            //                let dictionary = News.createDictionaryForm(json: metaJson)
            //                let entity = NSEntityDescription.entity(forEntityName: "News", in: DataService.viewContext())!
            //                let new = NSManagedObject(entity: entity, insertInto: DataService.viewContext()) as! News
            //                new.id = Int16(index)
            //                new.updateValuesFrom(dictionary: dictionary)
            //            }
            //            DataService.saveContext()
            //            let userInfo: [String: Any] = ["success": true]
        }
        requestController.failure = { [weak self] (err) in
            print(err.localizedDescription)
            self?.presenter?.newsFetchFailed(error: err)
            var userInfo: [String: Any] = [:]
            if News.allObjectsCount() != 0 {
                userInfo = ["success": true]
            } else {
                userInfo = ["success": false, "error": err]
            }
        }
        requestController.doGetRequest()
    }
    
    
}
