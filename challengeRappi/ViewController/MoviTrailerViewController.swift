//
//  MoviTrailerViewController.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 30/10/2022.
//

import UIKit
import WebKit

class MoviTrailerViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    var moviId: Int?
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetchOfficialTrailer(moviId: moviId ?? 0) {
            self.hideLoading()
            self.loadYoutube()
        } completeWithError: { error in
            print(error ?? "")
            self.hideLoading()
        }
    }
    

    func loadYoutube() {
        if let video = self.viewModel.officialTrailer {
            guard let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(video.key)")
            else { return }
            webView.load( URLRequest(url: youtubeURL) )
        } else {
            let alert = UIAlertController(title: "Error", message: "No se encontraron trailers para esta pelicula", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
