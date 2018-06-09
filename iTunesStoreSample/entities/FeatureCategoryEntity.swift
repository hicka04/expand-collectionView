//
//  FeatureCategoryEntity.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/05/29.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import Foundation

struct FeatureCategoryEntity: Codable {

    let categoryName: String
    let features: [FeatureEntity]
    
    private enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case features
    }
}
