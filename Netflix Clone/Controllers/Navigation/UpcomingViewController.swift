//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [TitleData] = []
    private var apiManager = MovieApiManager()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: K.titleTableCellId)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationItem.largeTitleDisplayMode = .always
        }
        
        view.addSubview(upcomingTable)
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        apiManager.delegate = self
        
        fetchUpcomingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcomingMovies() {
        apiManager.fetchUpcomingMovies()
    }
}

//MARK: - TabBarItem

extension UpcomingViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: K.SystemIcons.TabBar.comingSoon)
    }
    
    var titleString: String {
        return "Coming Soon"
    }
    
    var rootViewContoller: UIViewController {
        return self
    }
}

//MARK: - TableView Methods

extension UpcomingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
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

extension UpcomingViewController: MovieApiManagerDelegate {
    func didFetchUpcomingMovies(titles: [TitleData]) {
        self.titles = titles
        DispatchQueue.main.async {
            self.upcomingTable.reloadData()
        }
    }
}
