//
//  TabBarController.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 12/20/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc0 = UINavigationController(rootViewController: BikeListVC())
        vc0.tabBarItem = UITabBarItem(title: "Bikes", image: UIImage(systemName: "bicycle"), tag: 0)
        vc0.viewControllers.first?.navigationItem.title = "VC0"
        
        let vc1 = SliderVC()
        vc1.tabBarItem = UITabBarItem(title: "Ratio Calc", image: UIImage(systemName: "gearshape.2"), tag: 1)
        
        let vc2 = ScratchVC()
        vc2.tabBarItem = UITabBarItem(title: "Scratch", image: UIImage(systemName: "pencil.and.scribble"), tag: 2)
        
        viewControllers = [vc0, vc1, vc2]
        selectedIndex = 1
        
        tabBar.tintColor = .darkGray
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .yellow
    }
}
