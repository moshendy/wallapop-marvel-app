//
//  MockComicViewModel.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 06/06/2022.
//

import Foundation
@testable import Wallapop_Marvel_App

class MockComicViewModel{
    
    var comics = Comics()
    var comicDC = [ComicDataContainer]()
    var comicCellViewModels = [ComicCellViewModel]()
    
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
