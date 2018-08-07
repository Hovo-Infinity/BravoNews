//
//  GalleryViewController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/25/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class GalleryViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var galleryObjects: [GalleryObject]!
    private var collectionView: UICollectionView!
    
    init(gallery: [GalleryObject]!) {
        super.init(nibName: nil, bundle: nil)
        galleryObjects = gallery
        title = "Gallery"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
    }
    
    private func createCollectionView() {
        let y: CGFloat = 64
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 8, 8, 8)
        layout.minimumLineSpacing = 8
        let width = (view.bounds.width - 32) / 2
        layout.itemSize = CGSize(width: width, height: width)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: y, width: view.bounds.width, height: view.bounds.height - y), collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "galleryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let galleryObject = galleryObjects[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath)
        let width = (collectionView.bounds.width - 24) / 2
        let imageVew = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        imageVew.setImageFrom(URL(string: galleryObject.thumbnailUrl), thumbnail: UIImage(named: "loading"))
        cell.contentView.addSubview(imageVew)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gallery = galleryObjects[indexPath.item]
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionReveal
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let imageVC = ImageViewController(gallery: gallery)
        present(imageVC, animated: false, completion: nil)
    }
}
