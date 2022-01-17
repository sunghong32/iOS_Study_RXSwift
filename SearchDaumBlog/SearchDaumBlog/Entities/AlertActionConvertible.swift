//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 민성홍 on 2022/01/17.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
