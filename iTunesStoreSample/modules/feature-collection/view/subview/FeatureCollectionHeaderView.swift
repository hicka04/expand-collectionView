//
//  FeatureCollectionHeaderView.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/06/01.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import UIKit

class FeatureCollectionHeaderView: UICollectionReusableView {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
