//
//  ComicsViewModel.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import Foundation

class ComicsViewModel: NSObject {

    private var comicsService: ComicsServiceProtocol

    init(comicsService: ComicsServiceProtocol = ComicsService()) {
        self.comicsService = comicsService
    }
    
    var reloadTableView: (() -> Void)?
    var comics = Comics()
    
    var comicCellViewModels = [ComicCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    func getComics() {
        comicsService.getComics { success, model, error in
            if success, let comics = model {
                self.fetchData(comics: comics)
            } else {
                print(error!)
            }
        }
    }

    func fetchData(comics: Comics) {
        self.comics = comics // Cache
        var vms = [ComicCellViewModel]()
        for comic in comics {
            vms.append(createCellModel(comic: comic))
        }
        comicCellViewModels = vms
    }
    
    func createCellModel(comic: Comic) -> ComicCellViewModel {
        let id = comic.id
        let title = comic.title
        let image = comic.thumbnail?.path ?? ""
        let imageExt = comic.thumbnail?.ext ?? ""

        return ComicCellViewModel(id: id, title: title, image: image, imageExt: imageExt)
    }
    func getCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
        return comicCellViewModels[indexPath.row]
    }

}
