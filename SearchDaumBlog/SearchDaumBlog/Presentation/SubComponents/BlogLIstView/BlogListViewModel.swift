//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/02/22.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()

    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>

    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
