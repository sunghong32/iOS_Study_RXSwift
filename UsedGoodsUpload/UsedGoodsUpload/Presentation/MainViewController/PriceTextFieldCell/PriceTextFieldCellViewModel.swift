//
//  PriceTextFieldCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 민성홍 on 2022/02/23.
//

import RxCocoa
import RxSwift

struct PriceTextFieldCellViewModel {
    // ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>

    // View -> ViewModel
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()

    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false}
            )
            .asSignal(onErrorJustReturn: false)

        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
