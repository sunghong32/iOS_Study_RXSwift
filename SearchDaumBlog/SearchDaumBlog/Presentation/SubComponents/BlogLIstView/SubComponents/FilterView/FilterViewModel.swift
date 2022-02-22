//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/02/22.
//

import RxCocoa
import RxSwift

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
