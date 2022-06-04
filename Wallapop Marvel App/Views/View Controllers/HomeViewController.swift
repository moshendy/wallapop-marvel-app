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

    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchHeightCons: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!

    var page = 0
    var searchText = ""
    
    
    lazy var viewModel = {
        ComicsViewModel()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField customization
        searchTextField.setLeftPaddingPoints(15)
        searchTextField.delegate = self

        // TableView customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black
        tableView.separatorStyle = .singleLine
        tableView.register(ComicTableViewCell.nib, forCellReuseIdentifier: ComicTableViewCell.identifier)

        MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check For Internet Connection
        if (MyController.isConnectedToInternet() != 0){
            initViewModel()
        }else{
            MyController.viewAlertDialog(vc: self, title: "No internet connection", message: "")
        }
    }
    

    func initViewModel() {
        viewModel.getComics(offset:page)
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                MyController.hideLoading(vc: self ?? HomeViewController(),timeSeconds: 0.5)
            }
        }
    }
    @IBAction func toggleSeachBarBox(_ sender: UIButton) {
        if searchHeightCons.constant == 0{
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
                self.searchHeightCons.constant = 50
                self.view.layoutIfNeeded()
                sender.setImage(UIImage(systemName: "xmark"), for: .normal)
                self.searchTextField.isHidden = false
            }
        }else{
            self.view.endEditing(true)
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
                self.searchTextField.isHidden = true
                self.searchHeightCons.constant = 0
                self.view.layoutIfNeeded()
                sender.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            }
        }
    }
}
// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height-225) / 4
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        print(cellVM.title)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let total_pages = self.viewModel.comicDC[0].total
        let lastElement = viewModel.comicCellViewModels.count - 1
        
        //Load More Data on reaching last cell
        if indexPath.row == lastElement {
            if page + 20 >= total_pages {
                print("i am here \(page) \(total_pages)")
            }else{
                page = page + 20
                MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)
                if !MyController.isEmptyString(text: searchTextField.text ?? ""){
                    viewModel.getComicsByTitle(offset: page, title: searchTextField.text!)
                }else{
                    viewModel.getComics(offset:page)
                }
            }
        }
    }
}
// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        if searchText != textField.text ?? ""{
            MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)
            searchText = textField.text ?? ""

            if !MyController.isEmptyString(text: textField.text ?? ""){
                page = 0
                viewModel.getComicsByTitle(offset: page, title: textField.text!)
            }else{
                page = 0
                viewModel.getComics(offset:page)
            }
        }
        return true
    }
}
