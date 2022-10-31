//
//  TableViewCell.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 27/10/2022.
//

import UIKit

class MoviCellTableViewCell: UITableViewCell, UICollectionViewDataSource, MovieItemCollectionViewProtocol, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var movieCollection: UICollectionView!
    weak var delegate: MovieItemCollectionViewProtocol?
    let ReuseIdentifier = "cell"
    var movies: ResponseMovie?
    var currentDirection: UICollectionView.ScrollDirection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieCollection.contentInsetAdjustmentBehavior = .always
        self.movieCollection.register(UINib(nibName: "MovieItemCollection", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier)
        self.movieCollection.dataSource = self
        self.movieCollection.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func FillData(movies: ResponseMovie?, orientation: UICollectionView.ScrollDirection, delegate: MovieItemCollectionViewProtocol?) {
        self.movies = movies
        self.delegate = delegate
        self.currentDirection = orientation
        setScrollOrientation(orientation: orientation)
        self.movieCollection.reloadData()
    }
    
    func setScrollOrientation(orientation: UICollectionView.ScrollDirection) {
        if let layout = self.movieCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = orientation
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier, for: indexPath) as! MovieItemCollectionView
        cell.imageUrl = "\(Api.BASE_URL_IMAGE)\(self.movies?.results[indexPath.row].poster_path ?? "")"
        cell.moviId = self.movies?.results[indexPath.row].id
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.currentDirection == .horizontal ? CGSize(width: 138, height: 181) : CGSize(width: 156, height: 205)
    }
    
    func onPressMovie(moviId: Int?) {
        self.delegate?.onPressMovie(moviId: moviId)
    }

}
