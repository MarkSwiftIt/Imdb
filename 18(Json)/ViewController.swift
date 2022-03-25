//
//  ViewController.swift
//  18(Json)
//
//  Created by Mark Goncharov on 21.03.2022.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let service = Service()
    
    let tableViewCell = TableViewCell()
    var tableView: UITableView!
    
    var searchRespone: SearchRespone? = nil
    
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()

        title = "Movies"
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        
        let urlString = "https://imdb-api.com/en/API/Search/k_ys9h9w5r/inception%202010"
        
        service.request(urlString: urlString) { [ weak self ] (result) in
            switch result {
            case .success(let searchRespone):
                self?.searchRespone = searchRespone
                self?.tableView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    

    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let movies = searchRespone?.results[indexPath.row]
        cell.publishedAt.text = movies?.title
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRespone?.results.count ?? 0
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://imdb-api.com/en/API/Search/k_ys9h9w5r/\(searchText)"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                     repeats: false,
                                     block: { (_) in
            self.service.request(urlString: urlString) { [ weak self ] (result) in
                switch result {
                case .success(let searchRespone):
                    self?.searchRespone = searchRespone
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("error", error)
                }
            }
        })
    }
}
