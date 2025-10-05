//
//  HomeController.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import UIKit

class HomeController: CryptoBaseController {
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "\(HomeCell.self)")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        return activity
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresh
    }()
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func refreshData() {
        viewModel.refreshCoins()
        collection.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func configureUI() {
        view.backgroundColor = .white
        collection.refreshControl = refreshControl
        Task {
            await viewModel.fetchCoins()
        }
        viewModel.sendState = { [weak self] state in
            guard let self else { return }
            Task { @MainActor [weak self] in
                guard let self else { return }
                switch state {
                case .loading:
                    activityIndicator.startAnimating()
                case .loaded:
                    activityIndicator.stopAnimating()
                case .success:
                    collection.reloadData()
                case .error(let error):
                    showAlert(message: error)
                case .idle:
                    break
                }
            }
        }
    }
    
    override func configureConstraints() {
        view.backgroundColor = .green
        view.addSubViews(collection, activityIndicator)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeCell.self)",
                                                            for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: viewModel.coins[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
