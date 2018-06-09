//
//  FeatureItemCollectionViewCell.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/05/29.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var featureLabel: UILabel!
    var featureText: String? {
        didSet {
            featureLabel.text = featureText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
