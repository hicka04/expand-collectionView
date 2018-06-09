//
//  FeatureCollectionViewController.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/06/01.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import UIKit

class FeatureCollectionViewController: UIViewController {

    var presenter: FeatureCollectionViewPresentable!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    let CELL_ID = "cellId"
    let HEADER_ID = "headerId"
    let FOOTER_ID = "footerId"
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(
            UINib(nibName: FeatureCollectionViewCell.className, bundle: nil),
            forCellWithReuseIdentifier: CELL_ID)
        collectionView.register(
            UINib(nibName: FeatureCollectionHeaderView.className, bundle: nil),
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: HEADER_ID)
        collectionView.register(
            UINib(nibName: FeatureCollectionFooterView.className, bundle: nil),
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: FOOTER_ID)
        
        presenter.viewDidLoad()
    }
    
    @objc private func didSelectFooter(gestureRecognizer: UIGestureRecognizer) {
        guard let section = gestureRecognizer.view?.tag else {
            return
        }
        
        presenter.didSelectFooter(in: section)
    }
}

extension FeatureCollectionViewController: FeatureCollectionView {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func reloadSection(_ section: Int) {
        collectionView.reloadSections(IndexSet.init(integer: section))
    }
    
    func reloadItem(at indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - collectionview delegate datasource
extension FeatureCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! FeatureCollectionViewCell
        let (item, isSelected) = presenter.itemAndIsSelected(at: indexPath)
        cell.featureText = item.name
        cell.backgroundColor = isSelected ? .blue : .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_ID, for: indexPath) as! FeatureCollectionHeaderView
            header.setTitle(presenter.titleForHeader(in: indexPath.section))
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FOOTER_ID, for: indexPath) as! FeatureCollectionFooterView
            
            footer.tag = indexPath.section
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectFooter(gestureRecognizer:)))
            footer.addGestureRecognizer(tapGesture)
            
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension FeatureCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns = CGFloat(presenter.numberOfColumns)
        return CGSize(width: collectionView.frame.size.width / numberOfColumns - 16, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard presenter.shouldShowFooterView(in: section) else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.size.width, height: 32)
    }
}

// MARK: - searchbar delegate
extension FeatureCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.updateSearchText(searchText)
    }
}
