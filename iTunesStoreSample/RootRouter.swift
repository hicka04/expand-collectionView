//
//  RootRouter.swift
//  iTunesStoreSample
//
//  Created by HikaruSato on 2018/05/29.
//  Copyright © 2018年 HikaruSato. All rights reserved.
//

import UIKit

class RootRouter {
    
    static func showRootView(window: UIWindow) {
//        let view = FeatureListRouter.assembleModule()
        let view = FeatureCollectionRouter.assembleModule()
        let navigationController = UINavigationController(rootViewController: view)
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }
}
