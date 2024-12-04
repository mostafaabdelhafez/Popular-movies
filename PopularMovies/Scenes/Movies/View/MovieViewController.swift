//
//  MovieViewController.swift
//  PopularMovies
//
//  Created by jobzella on 12/2/24.
//

import UIKit

class MovieViewController: UIViewController ,UISearchResultsUpdating,UISearchBarDelegate{
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var moviesTableView: UITableView!{
        didSet{
            moviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            
        }
    }
    
    private var viewModel = MovieViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text ?? ""
        
        if !searchText.isEmpty {
            viewModel.searchMovies(query: searchText, page: 1)
        }
        else{
            viewModel.didRemoveSearch()
        }
    }

    func navigateToDetails(id:Int){
        let detailsVC = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        detailsVC.movieId = id
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies ..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func setupNavbar(){
        navigationItem.title = "Popular Movies"
        // Enable large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    func setupTableView(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self

    }
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSearchBar()

        setupTableView()
        viewModel.moviesDidChange = { [weak self] in
            
            self?.moviesTableView.reloadData()
        }
        
        viewModel.showError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }
        viewModel.isLoading = {[weak self] loading in
            if loading{
                self?.moviesTableView.isHidden = true
                self?.indicator.isHidden = false
                self?.indicator.startAnimating()
            }
            else{
                self?.moviesTableView.isHidden = false
                self?.indicator.isHidden = true
                self?.indicator.stopAnimating()

            }
        }
        viewModel.fetchPopularMovies(page: 1)

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
extension MovieViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovieCount()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let movie = viewModel.getMovie(at: indexPath.row) {
            
            cell.textLabel?.text = movie.title
        }
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetails(id: viewModel.getMovie(at: indexPath.row)!.id!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
