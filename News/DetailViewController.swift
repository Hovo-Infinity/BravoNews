//
//  DetailViewController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/25/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import AVKit

class DetailViewController: BaseViewController {
    
    private let scrollView: UIScrollView! = UIScrollView()
    private var news: News?
    
    init(new: News) {
        super.init(nibName: nil, bundle: nil)
        news = new
        title = "Detail"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        view.addSubview(scrollView)
        addTitleLabel()
        addImage()
        addBodyLabel()
        addVideoAndGalleryButton()
        addCategoryAndDetail()
        UserDefaults.standard.set(true, forKey: (news?.coverPhotoUrl!)!)
    }
    
    private func addTitleLabel() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 8, width: view.frame.width - 16, height: 20))
        titleLabel.numberOfLines = 0
        titleLabel.text = news?.title
        titleLabel.sizeToFit()
        updateScrollViewContentSizeFor(view: titleLabel, offset: 8)
    }
    
    private func addCategoryAndDetail() {
        let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: 0))
        categoryLabel.text = news?.category
        categoryLabel.sizeToFit()
        let dateLabel = UILabel(frame: CGRect(x: view.frame.width / 2, y: 0, width: view.frame.width / 2 - 16, height: 0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateLabel.text = dateFormatter.string(from: (news?.date)!)
        dateLabel.sizeToFit()
        dateLabel.textAlignment = .left
        let detailView = UIView(frame: CGRect(x: 8, y: scrollView.contentSize.height + 20, width: view.frame.width - 16, height: dateLabel.frame.height))
        detailView.addSubview(categoryLabel)
        detailView.addSubview(dateLabel)
        updateScrollViewContentSizeFor(view: detailView, offset: 23)
    }
    
    private func addBodyLabel() {
        let bodyLabel = UILabel(frame: CGRect(x: 0, y: scrollView.contentSize.height + 20, width: view.frame.width - 16, height: 20))
        bodyLabel.numberOfLines = 0
        let attributedString = try! NSMutableAttributedString(data: (news?.body?.data(using: .utf8)!)!,
                                                              options: [.documentType : NSAttributedString.DocumentType.html,
                                                                        .characterEncoding: String.Encoding.utf8.rawValue],
                                                              documentAttributes: nil)
        attributedString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)], range: NSMakeRange(0, attributedString.length))
        bodyLabel.attributedText = attributedString
        bodyLabel.sizeToFit()
        updateScrollViewContentSizeFor(view: bodyLabel, offset: 20)
    }
    
    private func addImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: scrollView.contentSize.height + 20, width: view.frame.width, height: 0))
        let url = URL(string: (news?.coverPhotoUrl)!)
        let loadingImage = UIImage(named: "loading")
        imageView.setImageFrom(url, thumbnail: loadingImage)
        imageView.correctSizeForAspectRatio()
        updateScrollViewContentSizeFor(view: imageView, offset: 20)
    }
    
    private func addVideoAndGalleryButton() {
        if news?.gallery != nil {
            let galleryButton = UIButton(frame: CGRect(x: 8, y: scrollView.contentSize.height + 20, width: view.frame.width - 16, height: 40))
            galleryButton.setTitle("Gallery", for: .normal)
            galleryButton.setTitleColor(.blue, for: .normal)
            galleryButton.backgroundColor = .cyan
            galleryButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
            updateScrollViewContentSizeFor(view: galleryButton, offset: 20)
        }
        if news?.videoYoutubeId != nil {
            let videoButton = UIButton(frame: CGRect(x: 8, y: scrollView.contentSize.height + 2, width: view.frame.width - 16, height: 40))
            videoButton.setTitle("Video", for: .normal)
            videoButton.setTitleColor(.blue, for: .normal)
            videoButton.backgroundColor = .cyan
            videoButton.addTarget(self, action: #selector(openVideo), for: .touchUpInside)
            updateScrollViewContentSizeFor(view: videoButton, offset: 2)
        }
    }
    
    private func updateScrollViewContentSizeFor(view: UIView!, offset: CGFloat) {
        scrollView.addSubview(view)
        var oldSize = scrollView.contentSize
        oldSize.height += view.frame.height + offset
        scrollView.contentSize = oldSize
    }
    
    // MARK: - Button Actions
    
    @objc
    func openGallery() {
        let galleryVC = GalleryViewController(gallery: (news?.gallery)!)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(galleryVC, animated: false, completion: nil)
    }
    
    @objc
    func openVideo() {
        var youtubeUrl = URL(string:"youtube://" + (news?.videoYoutubeId)!)!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        } else{
            youtubeUrl = URL(string:"https://www.youtube.com/watch?v=" + (news?.videoYoutubeId)!)!
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
    }
}
