//
//  MainModel.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/02/22.
//

import RxSwift
import UIKit 

struct MainModel {
    let network = SearchBlogNetwork()

    func seachBlog(_ query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        return network.searchBlog(query: query)
    }

    func getBlogValue(_ result: Result<DKBlog, SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result else {
            return nil
        }

        return value
    }

    func getBlogError(_ result: Result<DKBlog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }

        return error.localizedDescription
    }

    func getBlogListCellData(_ value: DKBlog) -> [BlogListCellData] {
        return value.documents
            .map {
                let thumbnailURL = URL(string: $0.thumbnail ?? "")
                return BlogListCellData(thumbnailURL: thumbnailURL, name: $0.name, title: $0.title, dateTime: $0.datetime)
            }
    }

    func sort(by type: MainViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
            case .title:
                return data.sorted { $0.title ?? "" < $1.title ?? "" }
            case .datetime:
                return data.sorted { $0.dateTime ?? Date() > $1.dateTime ?? Date() }
            default:
                return data
        }
    }
}
