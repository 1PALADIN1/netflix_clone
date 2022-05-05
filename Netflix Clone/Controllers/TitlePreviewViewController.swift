//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 04.05.2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    var previewTitle: TitleData?
    
    private var youtubeApiManager = YoutubeApiManager()
    private let dataManager = DataManager()
    
    private var youtubeVideoBaseUrl: String {
        return AppConfig.shared.youtubeVideoBaseUrl
    }
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        applyConstraints()
        
        youtubeApiManager.delegate = self
        configureTitle()
        
        downloadButton.addTarget(self, action: #selector(self.downloadButtonClicked), for: .touchUpInside)
    }
    
    private func applyConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 280)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    private func configureTitle() {
        guard let previewTitle = previewTitle else { return }
        
        titleLabel.text = previewTitle.titleName
        overviewLabel.text = previewTitle.overview
        
        let query = "\(previewTitle.titleName) trailer"
        youtubeApiManager.searchMovieOnYoutube(with: query)
    }
    
    @objc private func downloadButtonClicked(sender: UIButton!) {
        if let previewTitle = previewTitle {
            dataManager.downloadTitle(title: previewTitle)
        }
    }
}

//MARK: - YoutubeApiManagerDelegate

extension TitlePreviewViewController: YoutubeApiManagerDelegate {
    func didSearchOnYoutube(video: YoutubeData) {
        let urlString = "\(youtubeVideoBaseUrl)/\(video.id.videoId)"
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.webView.load(URLRequest(url: url))
        }
    }
}
