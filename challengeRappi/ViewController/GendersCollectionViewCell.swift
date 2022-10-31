//
//  GendersCollectionViewCell.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 29/10/2022.
//

import UIKit

class GendersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dot: UIView!
    @IBOutlet weak var genresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUI()
    }
    
    override func prepareForReuse() {
        self.setUI()
    }
    
    func setUI() {
        self.dot.layer.cornerRadius = self.dot.layer.frame.width / 2
    }
    
}
