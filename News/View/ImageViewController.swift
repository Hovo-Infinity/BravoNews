//
//  ImageViewController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/25/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class ImageViewController: BaseViewController {
    
    private var galleryObject: GalleryObject!
    
    init(gallery: GalleryObject!) {
        super.init(nibName: nil, bundle: nil)
        galleryObject = gallery
        title = gallery.title
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCenterImage()
    }

    private func addCenterImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 0))
        imageView.setImageFrom(URL(string: galleryObject.contentUrl), thumbnail: UIImage(named: "loading")) { (image, err) in
            if err == nil {
                imageView.correctSizeForAspectRatio()
            }
        }
        view.addSubview(imageView)
    }
}
