//
//  Contents.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/05.
//

import Foundation

struct Contents: Codable {
    var images: [Image]
    var info: Info
}

struct Image: Codable {
    var idiom: String
    var size: String
    var scale: String
    var filename: String
}

struct Info: Codable {
    var version: String
    var author: String
}
