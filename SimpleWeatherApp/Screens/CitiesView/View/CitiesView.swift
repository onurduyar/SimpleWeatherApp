//
//  CitiesView.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 24.05.2023.
//

import UIKit

final class CitiesView: UIView {
    // MARK: - Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
     lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter a City/County"
        return searchController
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    let tableView = UITableView()
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupTableView()
        configureActivityIndicator()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Methods
    func configureActivityIndicator() {
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func setTableViewDelegate(delegate: UITableViewDelegate,
                                   andDataSource dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    func setSearchControllerDelegate(delegate: UISearchControllerDelegate,
                                     resultUpdater: UISearchResultsUpdating) {
        searchController.delegate = delegate
        searchController.searchResultsUpdater = resultUpdater
    }
    func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
