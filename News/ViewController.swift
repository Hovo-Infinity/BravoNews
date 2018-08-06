//
//  ViewController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var collectionView: UICollectionView!
    private var response: [News]!
    private var loadingViewController: LoadingViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingViewController = LoadingViewController()
        addLoadingViewController()
        DataService.sharedInstance.startFetchingData()
    }

    private func addLoadingViewController() {
        loadingViewController.view.frame = view.bounds
        addChildViewController(loadingViewController)
        view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParentViewController: self)
    }
    
    private func removeLoadingViewController() {
        loadingViewController.willMove(toParentViewController: nil)
        loadingViewController.view.removeFromSuperview()
        loadingViewController.removeFromParentViewController()
    }
    
    @objc
    private func dataFetchEnded() {
        self.response = News.allObjects()
        removeLoadingViewController()
        createCollectionView()
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: view.frame.width - 16, height: 350)
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 2)
        var frame = view.bounds
        if #available(iOS 11.0, *) {
            frame.size.height -= view.safeAreaInsets.top
            frame.origin.y = view.safeAreaInsets.top
        } else {
            frame.size.height -= 20
            frame.origin.y = 20
        }
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionViewCell")
        collectionView.backgroundColor = .random;
        view.addSubview(collectionView)
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        let newsObject = response[indexPath.item]
        cell.date = newsObject.date
        cell.title = newsObject.title
        cell.category = newsObject.category
        let url = URL(string: newsObject.coverPhotoUrl!)
        let loadingImage = UIImage(named: "loading")
        cell.imageView.setImageFrom(url, thumbnail: loadingImage)
        cell.updateFrames()
        let isViewed = UserDefaults.standard.bool(forKey: newsObject.coverPhotoUrl!)
        cell.backgroundColor = isViewed ? .lightGray : .white
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let new = response[indexPath.item]
        let detailVC = DetailViewController(new: new)
        present(detailVC, animated: true) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = .lightGray
        }
    }
    
}

