//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var sectionTitles: [HomeSection] = []
    private var apiManager = MovieApiManager()
    private var headerView: HeroHeaderUIView?

    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: K.tableCellId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0,
                                                    width: view.bounds.width,
                                                    height: 450))
        homeFeedTable.tableHeaderView = headerView
        headerView?.delegate = self
        configureNavbar()
        
        sectionTitles = [
            HomeSection(name: "Trending Movies", sectionType: .TrendingMovies) { () in
                self.apiManager.fetchTrendingMovies()
            },
            HomeSection(name: "Trending TV", sectionType: .TrendingTV) { () in
                self.apiManager.fetchTrendingTv()
            },
            HomeSection(name: "Popular", sectionType: .Popular) { () in
                self.apiManager.fetchPopularMovies()
            },
            HomeSection(name: "Upcoming Movies", sectionType: .UpcomingMovies) { () in
                self.apiManager.fetchUpcomingMovies()
            },
            HomeSection(name: "Top Rated", sectionType: .TopRated) { () in
                self.apiManager.fetchTopRatedMovies()
            }
        ]
        
        apiManager.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavbar() {
        var image = UIImage(named: K.Icons.netflixLogo)
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: K.SystemIcons.NavBar.userProfile), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: K.SystemIcons.NavBar.play), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
}

//MARK: - TabBarItem

extension HomeViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: K.SystemIcons.TabBar.home)
    }
    
    var titleString: String {
        return "Home"
    }
    
    var rootViewContoller: UIViewController {
        return self;
    }
}

//MARK: - Table View Methods

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        if let headerTextLabel = header.textLabel {
            headerTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            headerTextLabel.frame = CGRect(x: header.bounds.origin.x + 20,
                                           y: header.bounds.origin.y,
                                           width: 100,
                                           height: header.bounds.height)
            headerTextLabel.textColor = .label
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellId, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        sectionTitles[indexPath.section].fetchData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //MARK: - TableView scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0,
                                                              y: min(0, -offset))
    }
}

//MARK: - MovieApiManagerDelegate

extension HomeViewController: MovieApiManagerDelegate {
    func didFetchTrendingMovies(titles: [TitleData]) {
        refreshSection(HomeSectionType.TrendingMovies, with: titles)
        
        if let randomTitle = titles.randomElement() {
            headerView?.configure(with: randomTitle)
        }
    }
    
    func didFetchTrendingTv(titles: [TitleData]) {
        refreshSection(HomeSectionType.TrendingTV, with: titles)
    }
    
    func didFetchPopularMovies(titles: [TitleData]) {
        refreshSection(HomeSectionType.Popular, with: titles)
    }
    
    func didFetchUpcomingMovies(titles: [TitleData]) {
        refreshSection(HomeSectionType.UpcomingMovies, with: titles)
    }
    
    func didFetchTopRatedMovies(titles: [TitleData]) {
        refreshSection(HomeSectionType.TopRated, with: titles)
    }
    
    private func refreshSection(_ section: HomeSectionType, with titles: [TitleData]) {
        DispatchQueue.main.async { [weak self] in
            let indexPath = IndexPath(row: 0, section: section.rawValue)
            guard let cell = self?.homeFeedTable.cellForRow(at: indexPath) as? CollectionViewTableViewCell else {
                return
            }
            
            cell.configure(with: titles)
        }
    }
}

//MARK: - TitleTapDelegate

extension HomeViewController: TitleTapDelegate {
    func didTapOnTitle(title: TitleData) {
        DispatchQueue.main.async { [weak self] in
            let titlePreviewVC = TitlePreviewViewController()
            titlePreviewVC.previewTitle = title
            self?.navigationController?.pushViewController(titlePreviewVC, animated: true)
        }
    }
}
