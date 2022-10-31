//
//  MoviesTableViewController.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation
import UIKit

class MoviesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, TitleFilterSectionViewProtocol, MovieItemCollectionViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    let headerIdentifier = "headerSection"
    let cellIdentifier = "row"
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none;
        self.showLoading()
        self.loadNextMovies()
    }
    
    func loadNextMovies() {
        viewModel.fetchMoviesUpcoming {
            self.loadTopicMovies()
        } completeWithError: { error in
            print("Error fetching next movies")
            self.loadTopicMovies()
        }
    }
    
    func loadTopicMovies() {
        viewModel.fetchMoviesTopRated {
            self.loadRecommendedForYou()
        } completeWithError: { error in
            print("Error fetching topic movies")
            self.loadRecommendedForYou()
        }
    }
    
    func loadRecommendedForYou() {
        viewModel.fetchRecommendedMovies {
            self.tableView.reloadData()
            self.hideLoading()
        } completeWithError: { error in
            print("Error fetching recommended movies")
            self.tableView.reloadData()
            self.hideLoading()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.viewModel.list[indexPath.section].rowHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.viewModel.list[section].header
        header.setValue(title: self.viewModel.list[section].title, delegate: self)
        return header as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.viewModel.list[section].headerHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MoviCellTableViewCell
        cell.FillData(movies: self.viewModel.list[indexPath.section].movie, orientation: self.viewModel.list[indexPath.section].orientation, delegate: self)
        return cell
    }
    
    func onPressInSpanish() {
        print("onPressInSpanish")
        self.viewModel.filterSpanishMovies()
        let indexPath = IndexPath.init(row: 0, section: 2)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func onPressLaunched1993() {
        print("onPressLaunched1993")
        self.viewModel.filterByYear()
        let indexPath = IndexPath.init(row: 0, section: 2)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func onPressMovie(moviId: Int?) {
        print(moviId ?? 0)
        let DetailMovi = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        DetailMovi.moviId = moviId
        self.navigationController?.pushViewController(DetailMovi, animated: true)
    }
}
