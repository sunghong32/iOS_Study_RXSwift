//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/02/22.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let shouldLoadResult: Observable<String>
    let searchButtonTapped = PublishRelay<Void>()
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
