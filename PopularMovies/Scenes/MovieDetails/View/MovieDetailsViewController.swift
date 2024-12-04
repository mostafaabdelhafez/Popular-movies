//
//  MovieDetailsViewController.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieId:Int!
    @IBOutlet weak var movieDetailsTableView: UITableView!{
        didSet{

            let detailsNib = UINib(nibName: "MovieDetailsTableViewCell", bundle: nil)

            movieDetailsTableView.register(detailsNib.self, forCellReuseIdentifier: MovieDetailsTableViewCell.identifier)
            
            let similarNib = UINib(nibName: "SimilarMoviesTableViewCell", bundle: nil)

            movieDetailsTableView.register(similarNib.self, forCellReuseIdentifier: SimilarMoviesTableViewCell.identifier)

        }
    }
    func setupTableView(){
        movieDetailsTableView.delegate = self
        movieDetailsTableView.dataSource = self

    }
    private var viewModel = MovieDetailsViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.movieDetailsDidChange = { [weak self] in
            
            self?.movieDetailsTableView.reloadData()
        }
        viewModel.similarMovieDetailsDidChange = { [weak self] in
            
            self?.movieDetailsTableView.reloadData()
        }

        viewModel.fetchMovieDetails(id: movieId)

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MovieDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0 :
        return UITableView.automaticDimension
        case 1:
            return  180
        case 2:
            return 100
        default:return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.identifier, for: indexPath) as! MovieDetailsTableViewCell
            if let details = viewModel.getDetails(){
                cell.details = details
            }
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesTableViewCell.identifier, for: indexPath) as! SimilarMoviesTableViewCell

            cell.headlineTitle = "Similar Movies"
            if let similar = viewModel.getSimilarMovies(){
                cell.movies = similar
            }

            return cell

        default:return UITableViewCell()
        }
    }
    
    
}
