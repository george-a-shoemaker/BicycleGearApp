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
        
        let navController0 = UINavigationController(rootViewController: BikeListVC())
        navController0.tabBarItem = UITabBarItem(title: "Bikes", image: UIImage(systemName: "bicycle"), tag: 0)
        navController0.viewControllers.first?.navigationItem.title = "VC0"
        
        let vc1 = SliderVC()
        vc1.tabBarItem = UITabBarItem(title: "Ratio Calc", image: UIImage(systemName: "gearshape.2"), tag: 1)
        
        viewControllers = [navController0, vc1]
        selectedIndex = 0
        
        tabBar.tintColor = .darkGray
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .yellow
    }
}
