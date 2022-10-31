//
//  MovieRow.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import UIKit
import AlamofireImage

protocol MovieItemCollectionViewProtocol: AnyObject {
    func onPressMovie(moviId: Int?)
}

class MovieItemCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    weak var delegate: MovieItemCollectionViewProtocol?
    var moviId: Int?
    var imageUrl: String? {
        didSet {
            if let i = imageUrl {
                let url = URL(string: i)
                self.imageMovie.af.setImage(withURL: url!)
                setStyleImageProfile()
            }
        }
    }
    
    override func prepareForReuse() {
        setStyleImageProfile()
    }
    
    func setStyleImageProfile() {
        self.imageMovie.layer.masksToBounds = true
        self.imageMovie.layer.cornerRadius = 8
        self.imageMovie.contentMode = .scaleAspectFill
    }
    
    
    @IBAction func onPressMovie(_ sender: Any) {
        self.delegate?.onPressMovie(moviId: moviId)
    }
}
