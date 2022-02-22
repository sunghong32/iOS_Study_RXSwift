//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/02/22.
//

import RxCocoa
import RxSwift
import UIKit

struct MainViewModel {
    let disposeBag = DisposeBag()

    let blogListViewModel = BlogListViewModel()
    let searchBarViewModel = SearchBarViewModel()

    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()

    let shouldPresentAlert: Signal<MainViewController.Alert>

    init(model: MainModel = MainModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.seachBlog)
            .share()

        let blogValue = blogResult
            .compactMap(model.getBlogValue)

        let blogError = blogResult
            .compactMap(model.getBlogError)

        let cellData = blogValue
            .map(model.getBlogListCellData)

        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                    case .title, .datetime:
                        return true
                    default:
                        return false
                }
            }
            .startWith(.title)

        Observable
            .combineLatest(sortedType, cellData, resultSelector: model.sort)
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)

        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }

        let alertForErrorMessage = blogError
            .do(onNext: { message in
                print("error: \(message)")
            })
            .map { message -> MainViewController.Alert in
                return (
                    title: "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }

        self.shouldPresentAlert = Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
