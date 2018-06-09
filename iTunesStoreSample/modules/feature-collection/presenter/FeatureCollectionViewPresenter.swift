//
//  FeatureCollectionViewPresenter.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/06/01.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import Foundation

class FeatureCollectionViewPresenter: NSObject {

    weak var view: FeatureCollectionView?
    let interactor: FeatureCollectionUsecase
    let router: FeatureCollectionWireframe
    private var selectedFeatures: Set<FeatureEntity.FeatureId> = []
    private var isExpandedSections: Set<Int> = []
    private var searchText: String = "" {
        didSet {
            interactor.narrowDown(from: searchText)
            view?.reloadData()
        }
    }
    
    init(view: FeatureCollectionView,
         interactor: FeatureCollectionUsecase,
         router: FeatureCollectionWireframe) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FeatureCollectionViewPresenter: FeatureCollectionViewPresentable {
    
    var numberOfSections: Int {
        return interactor.numberOfFeatureCategories
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    func shouldShowFooterView(in section: Int) -> Bool {
        return interactor.items(in: section).count > numberOfColumns && searchText.isEmpty
    }
    
    func numberOfItems(in section: Int) -> Int {
        let itemCount = interactor.items(in: section).count
        if isExpandedSections.contains(section) || !searchText.isEmpty {
            return itemCount
        } else {
            return min(itemCount, numberOfColumns)
        }
    }
    
    func titleForHeader(in section: Int) -> String {
        return interactor.categoryName(in: section)
    }
    
    func itemAndIsSelected(at indexPath: IndexPath) -> (item: FeatureEntity, isSelected: Bool) {
        let item = interactor.item(at: indexPath)
        let isSelected = selectedFeatures.contains(item.id)
        return (item: item, isSelected: isSelected)
    }
    
    func viewDidLoad() {
        view?.reloadData()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let item = interactor.item(at: indexPath)
        if selectedFeatures.contains(item.id) {
            selectedFeatures.remove(item.id)
        } else {
            selectedFeatures.update(with: interactor.item(at: indexPath).id)
        }
        
        view?.reloadItem(at: indexPath)
    }
    
    func didSelectFooter(in section: Int) {
        if isExpandedSections.contains(section) {
            isExpandedSections.remove(section)
        } else {
            isExpandedSections.update(with: section)
        }
        
        view?.reloadSection(section)
    }
    
    func updateSearchText(_ text: String) {
        searchText = text
    }
}
