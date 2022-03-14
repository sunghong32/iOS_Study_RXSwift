//
//  LocalAPI.swift
//  FIndCVS
//
//  Created by 민성홍 on 2022/03/14.
//

import Foundation

struct LocalAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/local/search/category.json"

    func getlocation(by mapPoint: MTMapPoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = LocalAPI.scheme
        components.host = LocalAPI.host
        components.path = LocalAPI.path

        components.queryItems = [
            URLQueryItem(name: "category_group_code", value: "CS2"),
            URLQueryItem(name: "x", value: "\(mapPoint.mapPointGeo().longitude)"),
            URLQueryItem(name: "y", value: "\(mapPoint.mapPointGeo().latitude)"),
            URLQueryItem(name: "radius", value: "500"),
            URLQueryItem(name: "sort", value: "distance")
        ]

        return components
    }
}
