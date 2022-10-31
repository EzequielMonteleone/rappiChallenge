//
//  TitleSectionView.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation
import UIKit

class TitleSectionView: UIView, TitleFilterSectionViewDataSource {
    
    @IBOutlet weak var titleSection: UILabel!
    
    func setValue(title: String, delegate: TitleFilterSectionViewProtocol?) {
        self.titleSection.text = title
    }
    
    class func Instance() -> TitleSectionView {
        let view = Bundle.main.loadNibNamed("TitleSection", owner: nil, options: nil)?.first as! TitleSectionView
        return view
    }
    
}
