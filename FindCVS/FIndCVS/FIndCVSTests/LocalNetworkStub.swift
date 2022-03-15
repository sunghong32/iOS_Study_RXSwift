//
//  LocalNetworkStub.swift
//  FIndCVS
//
//  Created by 민성홍 on 2022/03/14.
//

import Foundation
import RxSwift
import Stubber

@testable import FIndCVS

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}

