//
//  FeatureEntity.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/05/29.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import Foundation

struct FeatureEntity: Codable {
    
    typealias FeatureId = String
    let id: FeatureId
    let name: String
}
