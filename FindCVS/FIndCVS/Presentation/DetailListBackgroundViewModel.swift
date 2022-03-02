//
//  DetailListBackgroundViewModel.swift
//  FIndCVS
//
//  Created by 민성홍 on 2022/03/02.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
    // viewModel -> View
    let isStatusLabelHidden: Signal<Bool>

    // 외부에서 전달받을 값
    let shouldHideStatusLabel = PublishRelay<Bool>()

    init () {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
