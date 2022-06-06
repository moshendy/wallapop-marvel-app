//
//  ComicsViewModel.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import Foundation

class ComicsViewModel: NSObject {

    private var comicsService: ComicsServiceProtocol
    var reloadTableView: (() -> Void)?
    var reloadCollectionView: (() -> Void)?

    var comics = Comics()
    var comicDC = [ComicDataContainer]()

    init(comicsService: ComicsServiceProtocol = ComicsService()) {
        self.comicsService = comicsService
    }
    
    var comicCellViewModels = [ComicCellViewModel]() {
        didSet {
            reloadTableView?()
            reloadCollectionView?()
        }
    }

    // method getComics, to get the comics data from the JSON using the Comic Service protocol
    func getComics(offset: Int) {
        if offset == 0{
            comicCellViewModels = []
        }

        comicsService.getComics(offset: offset){ success, model, container, error in
            if success, let comics = model, let container = container {
                self.fetchData(comics: comics, comicDC: container)
            } else {
                print("error fetching data! : \(error!)")
            }
        }
    }
    
    // method getComics, to get the comics data filtered by title from the JSON using the Comic Service protocol
    func getComicsByTitle(offset: Int,title: String) {
        if offset == 0{
            comicCellViewModels = []
        }
        comicsService.getComicsByTitle(offset: offset,title: title){ success, model, container, error in
            if success, let comics = model, let container = container {
                self.fetchData(comics: comics, comicDC: container)
            } else {
                print("error fetching data! : \(error!)")
            }
        }
    }
    
    //If the request was successful, we passing the JSON model to the fetchData method
    func fetchData(comics: Comics, comicDC: ComicDataContainer) {
        self.comics = comics
        var vms = [ComicCellViewModel]()
        //we’re looping through the items list, and we create a new list of the cell’s view model using the createCellModel method
        for comic in comics {
            vms.append(createCellModel(comic: comic))
        }
        comicCellViewModels = comicCellViewModels + vms
        self.comicDC = [comicDC]
    }
    
    func createCellModel(comic: Comic) -> ComicCellViewModel {
        let id = comic.id
        let title = comic.title
        let image = comic.thumbnail?.path ?? ""
        let imageExt = comic.thumbnail?.ext ?? ""
        let variantDescription = comic.variantDescription
        let description = comic.description
        let pageCount = comic.pageCount
        let price = comic.prices?[0].price
        let format = comic.format
        let focDate = comic.dates?[1].date
        let onSaleDate = comic.dates?[0].date

        return ComicCellViewModel(id: id, title: title, image: image, imageExt: imageExt, description: description, variantDescription: variantDescription, pageCount: pageCount, price: price ?? 0, format: format, focDate: focDate ?? "", onSaleDate: onSaleDate ?? "")
    }
    //return the cell view model for the current IndexPath
    func getCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
        return comicCellViewModels[indexPath.row]
    }

}
