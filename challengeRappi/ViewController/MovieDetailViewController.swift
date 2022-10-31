//
//  MovieDetailViewController.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 28/10/2022.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var seeTrailerButton: UIButton!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var moviName: UILabel!
    @IBOutlet weak var moviImage: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearContainer: UIView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var languageContainer: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingContainer: UIView!
    @IBOutlet weak var overview: UILabel!
    
    
    let viewModel = MoviesViewModel()
    var moviId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.setUI()
        viewModel.fetchMoviDetail(moviId: moviId ?? 0) {
            self.hideLoading()
            self.setValues()
        } completeWithError: { error in
            print(error ?? "")
            self.hideLoading()
        }
    }
    
    func setUI() {
        self.yearContainer.layer.cornerRadius = 4
        self.languageContainer.layer.cornerRadius = 4
        self.ratingContainer.layer.cornerRadius = 4
        self.seeTrailerButton.layer.cornerRadius = 8
        self.seeTrailerButton.layer.borderWidth = 0.5
        self.seeTrailerButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func setValues() {
        let urlImage = "\(Api.BASE_URL_IMAGE)\(self.viewModel.movieDetail!.poster_path)"
        let url = URL(string: urlImage)
        self.moviImage.af.setImage(withURL: url!)
        self.moviImage.layer.opacity = 0.5
        self.moviImage.contentMode = .scaleAspectFill
        self.moviImage.layer.masksToBounds = true
        self.moviImage.layer.cornerRadius = 8
        self.moviName.text = self.viewModel.movieDetail?.title
        self.languageName.text = self.viewModel.movieDetail?.original_language
        self.yearLabel.text = self.viewModel.movieDetail?.release_date.components(separatedBy: "-")[0]
        self.ratingLabel.text = String(format: "%.2f", self.viewModel.movieDetail?.vote_average ?? 0)
        var _genres: String = ""
        var index = 1
        self.viewModel.movieDetail?.genres?.forEach({ item in
            _genres += index == self.viewModel.movieDetail?.genres?.count ? "\(item.name)" : "\(item.name) • "
            index += 1
        })
        self.genresLabel.text = _genres
        self.overview.text = self.viewModel.movieDetail?.overview
    }
    
    
    @IBAction func onPressSeeTrailer(_ sender: Any) {
        let Trailer = self.storyboard?.instantiateViewController(withIdentifier: "MoviTrailerViewController") as! MoviTrailerViewController
        Trailer.moviId = moviId
        self.navigationController?.pushViewController(Trailer, animated: true)
    }
    
}
