//
//  SearchBlogNetwork.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/01/17.
//

import RxSwift
import Foundation

enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK fbc3a8e1924c86428ccf70eadb59d3bf", forHTTPHeaderField: "Authorization")

        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
}
