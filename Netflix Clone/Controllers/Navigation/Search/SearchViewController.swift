//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [TitleData] = []
    private var apiManager = MovieApiManager()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: K.titleTableCellId)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationItem.largeTitleDisplayMode = .always
            navigationController.navigationBar.tintColor = .label
        }
        
        view.addSubview(discoverTable)
        discoverTable.dataSource = self
        discoverTable.delegate = self
        apiManager.delegate = self
        searchController.searchResultsUpdater = self
        
        fetchDiscoverMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func fetchDiscoverMovies() {
        apiManager.fetchDiscoverMovies()
    }
}

//MARK: - TabBarItem

extension SearchViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: K.SystemIcons.TabBar.search)
    }
    
    var titleString: String {
        return "Top Searches"
    }
    
    var rootViewContoller: UIViewController {
        return self
    }
}

//MARK: - TableView Methods

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.titleTableCellId, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: titles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

//MARK: - MovieApiManagerDelegate

extension SearchViewController: MovieApiManagerDelegate {
    func didFetchDiscoverMovies(titles: [TitleData]) {
        self.titles = titles
        DispatchQueue.main.async {
            self.discoverTable.reloadData()
        }
    }
    
    func didSearchWithQuery(titles: [TitleData]) {
        DispatchQueue.main.async {
            guard let resultsController = self.searchController.searchResultsController as? SearchResultsViewController else {
                return
            }
            resultsController.setSearchResults(titles: titles)
        }
    }
}

//MARK: - Search Results Updater

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text else { return }
        apiManager.search(with: query)
    }
}
