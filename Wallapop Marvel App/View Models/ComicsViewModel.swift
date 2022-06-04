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
    
    var comics = Comics()
    var comicDC = [ComicDataContainer]()

    init(comicsService: ComicsServiceProtocol = ComicsService()) {
        self.comicsService = comicsService
    }
    
    var comicCellViewModels = [ComicCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }


    func getComics(offset: Int) {
        if offset == 0{
            comicCellViewModels = []
        }

        comicsService.getComics(offset: offset){ success, model, container, error in
            if success, let comics = model, let container = container {
                self.fetchData(comics: comics, comicDC: container)
            } else {
                print(error!)
            }
        }
    }
    func fetchData(comics: Comics, comicDC: ComicDataContainer) {
        self.comics = comics
        var vms = [ComicCellViewModel]()
        for comic in comics {
            vms.append(createCellModel(comic: comic))
        }
        comicCellViewModels = comicCellViewModels + vms
        self.comicDC = [comicDC]
    }

    func getComicsByTitle(offset: Int,title: String) {
        if offset == 0{
            comicCellViewModels = []
        }
        comicsService.getComicsByTitle(offset: offset,title: title){ success, model, container, error in
            if success, let comics = model, let container = container {
                self.fetchFilteredData(comics: comics, comicDC: container)
            } else {
                print(error!)
            }
        }
    }
    func fetchFilteredData(comics: Comics, comicDC: ComicDataContainer) {
        self.comics = comics
        var vms = [ComicCellViewModel]()
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

        return ComicCellViewModel(id: id, title: title, image: image, imageExt: imageExt, description: description, variantDescription: variantDescription, pageCount: pageCount, price: price ?? 0)
    }
    func getCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
        return comicCellViewModels[indexPath.row]
    }

}
