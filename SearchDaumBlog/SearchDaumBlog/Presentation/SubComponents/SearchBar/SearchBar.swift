//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/01/17.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()

    let searchButton = UIButton()

    let searchButtonTapped = PublishRelay<Void>()

    var shouldLoadResult = Observable<String>.of("")

    override init(frame: CGRect) {
        super.init(frame: frame)

        bind()
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(), //키보드의 search 버튼 (enter 버튼)
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)

        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)

        self.shouldLoadResult = self.rx.text.asObservable().map({ element -> String in
            return element ?? ""
        })
            .sample(searchButtonTapped, defaultValue: "")
            .filter {
                !$0.isEmpty
            }
//        self.shouldLoadResult = searchButtonTapped
//            .withLatestFrom(self.rx.text) { $1 ?? "" }
//            .filter { !$0.isEmpty }
//            .distinctUntilChanged()
    }

    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }

    private func layout() {
        addSubview(searchButton)

        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }

        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
