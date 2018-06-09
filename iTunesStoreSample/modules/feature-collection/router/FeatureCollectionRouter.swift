//
//  FeatureCollectionRouter.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/06/01.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import UIKit

class FeatureCollectionRouter: NSObject {

    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> UIViewController {
        let view = FeatureCollectionViewController()
        let interactor = FeatureListInteractor()
        let router = FeatureCollectionRouter(viewController: view)
        let presenter = FeatureCollectionViewPresenter(view: view,
                                                       interactor: interactor,
                                                       router: router)
        
        view.presenter = presenter
        
        return view
    }
}

extension FeatureCollectionRouter: FeatureCollectionWireframe {
    
}
