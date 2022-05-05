//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 27.04.2022.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles: [TitleEntity] = []
    private var dataManager = DataManager()
    
    private let downloadsTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: K.titleTableCellId)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Downloads"
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationItem.largeTitleDisplayMode = .always
            navigationController.navigationBar.tintColor = .label
        }
        
        downloadsTable.dataSource = self
        downloadsTable.delegate = self
        dataManager.delegate = self
        
        view.addSubview(downloadsTable)
        
        refreshTable()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(K.Notifications.titleDownloaded), object: nil, queue: nil) { [weak self] _ in
            self?.refreshTable()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadsTable.frame = view.bounds
    }
    
    private func refreshTable() {
        dataManager.fetchAllTitles()
    }
}

//MARK: - TabBarItem

extension DownloadsViewController: TabBarItem {
    var icon: UIImage? {
        return UIImage(systemName: K.SystemIcons.TabBar.downloads)
    }
    
    var titleString: String {
        return "Downloads"
    }
    
    var rootViewContoller: UIViewController {
        return self
    }
}

//MARK: - TableView Methods

extension DownloadsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.titleTableCellId, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let titleData = TitleData.createFromEntity(entity: titles[indexPath.row])
        cell.configure(with: titleData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let titlePreviewVC = TitlePreviewViewController()
        titlePreviewVC.previewTitle = TitleData.createFromEntity(entity: titles[indexPath.row])
        navigationController?.pushViewController(titlePreviewVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            dataManager.deleteTitleWith(entity: titles[indexPath.row])
            titles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
}

//MARK: - DataManagerDelegate

extension DownloadsViewController: DataManagerDelegate {
    func didFetchAllTitles(titles: [TitleEntity]) {
        DispatchQueue.main.async { [weak self] in
            self?.titles = titles
            self?.downloadsTable.reloadData()
        }
    }
}
