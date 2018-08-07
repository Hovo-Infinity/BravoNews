//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    let maxSize = UIScreen.main.bounds.size
    private var dateLabel: UILabel!
    private var categoryLabel: UILabel!
    private var titleLabel: UILabel!
    public let imageView: UIImageView! = UIImageView()
    
    public var title: String! {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
        }
    }
    
    public var category: String! {
        didSet {
            categoryLabel.text = category
            categoryLabel.sizeToFit()
        }
    }
    
    public var date: Date! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            dateLabel.text = dateFormatter.string(from: date)
            dateLabel.sizeToFit()
        }
    }
    
    public func updateFrames() {
        categoryLabel.frame = CGRect(x: 8, y: bounds.maxY - categoryLabel.bounds.height, width: categoryLabel.bounds.width, height: categoryLabel.bounds.height)
        dateLabel.frame = CGRect(x: bounds.maxX - dateLabel.bounds.width - 8, y: bounds.maxY - dateLabel.bounds.height, width: dateLabel.bounds.width, height: dateLabel.bounds.height)
        titleLabel.frame = CGRect(x: 8, y: categoryLabel.frame.minY - 8 - titleLabel.bounds.height, width: titleLabel.bounds.width - 16, height: titleLabel.bounds.height)
        let aspectRatio = 1.61575178998
        let height = Double(bounds.width) / aspectRatio
        imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: bounds.width, height: CGFloat(height)))
    }
    
    override init(frame: CGRect) {
        dateLabel = UILabel(frame: CGRect(x: 8, y: 0, width: frame.width, height: 20))
        categoryLabel = UILabel(frame: CGRect(x: 8, y: 20, width: frame.width, height: 20))
        titleLabel = UILabel(frame: CGRect(x: 8, y: 40, width: frame.width, height: 20))
        titleLabel.numberOfLines = 0
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(dateLabel)
        addSubview(imageView)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        dateLabel.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: 20))
        titleLabel.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: 20))
        dateLabel.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: 20))
    }
}
