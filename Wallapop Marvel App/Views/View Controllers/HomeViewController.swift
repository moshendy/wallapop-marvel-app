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
import Spring

class HomeViewController: UIViewController {
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var gridBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionviewContainer: SpringView!
    @IBOutlet weak var tableviewContainer: SpringView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchHeightCons: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    var page = 0
    var searchText = ""
    var selectedCellIndex : IndexPath?
    var defaultLayout = "Table"

    
    var viewModel = {
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
        
        // collectionView customization
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ComicCollectionViewCell.nib, forCellWithReuseIdentifier: ComicCollectionViewCell.identifier)
        
        MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)
        initViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check For Internet Connection
        if (MyController.isConnectedToInternet() == 0){
            MyController.viewAlertDialog(vc: self, title: "No internet connection", message: "")
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initViewModel() {
        viewModel.getComics(offset:page)
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                MyController.hideLoading(vc: self ?? HomeViewController(),timeSeconds: 0.5)
            }
        }
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                MyController.hideLoading(vc: self ?? HomeViewController(),timeSeconds: 0.5)
            }
        }
    }
    
    func setAnimationProperties(){
        self.collectionviewContainer.velocity = 0.7
        self.collectionviewContainer.duration = 1
        self.collectionviewContainer.delay = 0
        self.collectionviewContainer.force = 1
        self.collectionviewContainer.damping = 1

        self.tableviewContainer.damping = 1
        self.tableviewContainer.force = 1
        self.tableviewContainer.delay = 0
        self.tableviewContainer.duration = 1
        self.tableviewContainer.velocity = 0.7
    }
    
    @IBAction func toggleSeachBarBox(_ sender: UIButton) {
        if searchHeightCons.constant == 0{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.searchHeightCons.constant = 50
                self.view.layoutIfNeeded()
                sender.setImage(UIImage(systemName: "xmark"), for: .normal)
                self.searchTextField.isHidden = false
            }
        }else{
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.searchTextField.isHidden = true
                self.searchHeightCons.constant = 0
                self.view.layoutIfNeeded()
                sender.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            }
        }
    }
    @IBAction func toggleListGridView(_ sender: UIButton) {
        setAnimationProperties()
        if sender.tag == 1{
            if defaultLayout != "Table"{
                MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)

                defaultLayout = "Table"
                self.collectionviewContainer.animation = "squeezeRight"
                self.tableviewContainer.animation = "squeezeLeft"
                gridBtn.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
                listBtn.setImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .normal)

                collectionviewContainer.animateToNext {
                    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) {
                        self.collectionviewContainer.alpha = 0
                        self.tableviewContainer.alpha = 1
                        self.view.layoutIfNeeded()
                    }
                    self.tableviewContainer.animate()
                    MyController.hideLoading(vc: self)
                }
            }
        }else{
            
            if defaultLayout != "Grid"{
                MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)

                defaultLayout = "Grid"
                gridBtn.setImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
                listBtn.setImage(UIImage(systemName: "list.bullet.rectangle"), for: .normal)
                self.tableviewContainer.animation = "squeezeRight"
                self.collectionviewContainer.animation = "squeezeLeft"
                tableviewContainer.animateToNext {
                    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) {
                        self.tableviewContainer.alpha = 0
                        self.collectionviewContainer.alpha = 1
                        self.view.layoutIfNeeded()
                    }
                    self.collectionviewContainer.animate()
                    MyController.hideLoading(vc: self)
                }
            }
        }
    }
    func loadMore(){
        page = page + 25
        MyController.showDefaultLoading(vc: self, blur: false, colorName: .red)
        if !MyController.isEmptyString(text: searchTextField.text ?? ""){
            viewModel.getComicsByTitle(offset: page, title: searchTextField.text!)
        }else{
            viewModel.getComics(offset:page)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.viewComicSegue{
            if let selectedCell = selectedCellIndex{
                let cellVM = viewModel.getCellViewModel(at: selectedCell)
                let destinationViewController = segue.destination as! ComicViewController
                destinationViewController.comicTitle = cellVM.title
                destinationViewController.comicDescription = cellVM.description
                destinationViewController.pageCount = cellVM.pageCount
                destinationViewController.image = cellVM.image
                destinationViewController.price = cellVM.price
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
        selectedCellIndex = indexPath
        performSegue(withIdentifier: Constants.viewComicSegue, sender: self)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let total_pages = self.viewModel.comicDC[0].total
        let lastElement = viewModel.comicCellViewModels.count - 1
        
        //Load More Data on reaching last cell
        if indexPath.row == lastElement {
            if page + 25 >= total_pages {
            }else{
                loadMore()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comicCellViewModels.count
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier, for: indexPath) as? ComicCollectionViewCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        performSegue(withIdentifier: Constants.viewComicSegue, sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let total_pages = self.viewModel.comicDC[0].total
        let lastElement = viewModel.comicCellViewModels.count - 1
        
        //Load More Data on reaching last cell
        if indexPath.row == lastElement {
            if page + 25 >= total_pages {
            }else{
                loadMore()
            }
        }

    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.frame.width/2)-10, height: 210)
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
