//
//  BaseViewController.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import UIKit

class BaseViewController: UIViewController {

    let indicatorView: IndicatorView = IndicatorView.Instance()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
    }

    func showLoading() {
        self.view.addSubview(indicatorView)
        self.view.bringSubviewToFront(indicatorView)
        indicatorView.startAnimation()
    }
    
    func hideLoading() {
        indicatorView.stopAnimation()
        indicatorView.removeFromSuperview()
    }
    
}
