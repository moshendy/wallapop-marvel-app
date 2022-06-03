//
//  HomeViewController.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    
    lazy var viewModel = {
        ComicsViewModel()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initViewModel()
        MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)
    }
    
    func initTableView() {
        // TableView customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ComicTableViewCell.nib, forCellReuseIdentifier: ComicTableViewCell.identifier)
    }

    func initViewModel() {
        viewModel.getComics()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                MyController.hideLoading(vc: self!)
            }
        }
    }
}
// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.comicCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identifier, for: indexPath) as? ComicTableViewCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
