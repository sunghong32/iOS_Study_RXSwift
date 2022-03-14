//
//  LocalNetwork.swift
//  FIndCVS
//
//  Created by 민성홍 on 2022/03/14.
//

import RxSwift

class LocalNetwork {
    private let session: URLSession
    let api = LocalAPI()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        guard let url = api.getlocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 209857a05b9411930f109c0d55ef1ebd", forHTTPHeaderField: "Authorization")

        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    return .success(locationData)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
            .asSingle()
    }
}
