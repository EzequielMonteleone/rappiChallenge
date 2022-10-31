//
//  IndicatorView.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation
import UIKit

class IndicatorView: UIView {

    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    
    class func Instance() -> IndicatorView {
        let view = Bundle.main.loadNibNamed("Indicator", owner: nil, options: nil)?.first as! IndicatorView
        return view
    }
    
    func startAnimation() {
        Indicator.startAnimating()
    }
    
    func stopAnimation() {
        Indicator.stopAnimating()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
