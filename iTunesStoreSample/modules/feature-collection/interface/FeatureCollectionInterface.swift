//
//  FeatureCollectionInterface.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/05/31.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import UIKit

protocol FeatureCollectionView: class {
    
    func reloadData()
    func reloadSection(_ section: Int)
    func reloadItem(at indexPath: IndexPath)
}

protocol FeatureCollectionViewPresentable: class {
    
    var numberOfSections: Int { get }
    var numberOfColumns: Int { get }
    func shouldShowFooterView(in section: Int) -> Bool
    func numberOfItems(in section: Int) -> Int
    func titleForHeader(in section: Int) -> String
    func itemAndIsSelected(at indexPath: IndexPath) -> (item: FeatureEntity, isSelected: Bool)
    func viewDidLoad()
    
    func didSelectItem(at indexPath: IndexPath)
    func didSelectFooter(in section: Int)
    func updateSearchText(_ text: String)
}

protocol FeatureCollectionUsecase: class {
    
    var numberOfFeatureCategories: Int { get }
    func categoryName(in section: Int) -> String
    func items(in section: Int) -> [FeatureEntity]
    func item(at indexPath: IndexPath) -> FeatureEntity
    func narrowDown(from searchWord: String)
}

protocol FeatureCollectionWireframe: class {
    
}

