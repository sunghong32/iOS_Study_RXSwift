//
//  SearchBlogNetwork.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/01/17.
//

import Foundation

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()

    init(session: URLSession = .shared) {
        self.session = session
    }
}
