//
//  FeatureListInteractor.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/05/29.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import Foundation

class FeatureListInteractor {

    private let items: [FeatureCategoryEntity]
//        = [
//        FeatureCategoryEntity(categoryName: "バス・トイレ", features: [
//            FeatureEntity(id: "001", name: "バス・トイレ別"),
//            FeatureEntity(id: "002", name: "独立洗面台"),
//            FeatureEntity(id: "003", name: "追い焚き機能")
//            ]),
//        FeatureCategoryEntity(categoryName: "室内設備", features: [
//            FeatureEntity(id: "201", name: "フローリング"),
//            FeatureEntity(id: "202", name: "ロフト"),
//            FeatureEntity(id: "203", name: "ベランダ"),
//            FeatureEntity(id: "204", name: "バルコニー"),
//            FeatureEntity(id: "205", name: "バリアフリー"),
//            FeatureEntity(id: "206", name: "ウォークインクローゼット"),
//            FeatureEntity(id: "207", name: "床下収納"),
//            FeatureEntity(id: "208", name: "トランクルーム"),
//            FeatureEntity(id: "209", name: "都市ガス"),
//            FeatureEntity(id: "210", name: "プロパンガス"),
//            FeatureEntity(id: "211", name: "オール電化")
//            ]),
//        FeatureCategoryEntity(categoryName: "キッチン", features: [
//            FeatureEntity(id: "101", name: "コンロ2口以上"),
//            FeatureEntity(id: "102", name: "ガスキッチン"),
//            FeatureEntity(id: "103", name: "IHクッキングヒーター"),
//            FeatureEntity(id: "104", name: "システムキッチン"),
//            FeatureEntity(id: "105", name: "カウンターキッチン")
//            ])
//    ]
    
    private var searchWord: String = "" {
        didSet {
            guard !searchWord.isEmpty else {
                narrowDownedItems = items
                return
            }
            
            narrowDownedItems = items.map({ categoryEntity in
                let entities = categoryEntity.features.filter({ entity in
                    entity.name.contains(searchWord)
                })
                
                return FeatureCategoryEntity(categoryName: categoryEntity.categoryName, features: entities)
            })
        }
    }
    private var narrowDownedItems: [FeatureCategoryEntity]
    
    init() {
        guard let filePath = Bundle.main.path(forResource: "features", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let categories = try? JSONDecoder().decode(FeatureCategoriesEntity.self, from: data) else {
                fatalError()
        }
        items = categories.categories
        
        // 最初はとりあえず全部入りのやつ入れる
        narrowDownedItems = items
    }
}

extension FeatureListInteractor: FeatureCollectionUsecase {
    
    var numberOfFeatureCategories: Int {
        return narrowDownedItems.count
    }
    
    func categoryName(in section: Int) -> String {
        return narrowDownedItems[section].categoryName
    }
    
    func items(in section: Int) -> [FeatureEntity] {
        return narrowDownedItems[section].features
    }
    
    func item(at indexPath: IndexPath) -> FeatureEntity {
        return items(in: indexPath.section)[indexPath.row]
    }
    
    func narrowDown(from searchWord: String) {
        self.searchWord = searchWord
    }
}
