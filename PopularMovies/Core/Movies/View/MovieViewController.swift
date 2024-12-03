//
//  MovieViewController.swift
//  PopularMovies
//
//  Created by jobzella on 12/2/24.
//

import UIKit

class MovieViewController: UIViewController ,UISearchResultsUpdating{
    // Original data
    let allData = ["Apple", "Banana", "Orange", "Strawberry", "Pineapple", "Mango", "Grape"]
    
    // Filtered data based on search
    var filteredData = [String]()

    @IBOutlet weak var moviesTableView: UITableView!{
        didSet{
            moviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        }
    }

    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            // If the search text is empty, show the full list
            filteredData = allData
        } else {
            // Filter the data based on the search text
            filteredData = allData.filter { item in
                return item.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Reload the table view to reflect changes
        moviesTableView.reloadData()
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
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSearchBar()

        setupTableView()
        filteredData = allData

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
        return filteredData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
