//
//  ImageSizeConfig.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/05.
//

import Foundation

struct ImageGen {
    var appName:String
    var authorName:String
    
    let imageConfigs = [
        ImageConfig(idiom: .iphone, size: 29, scale: 1),
        ImageConfig(idiom: .iphone, size: 29, scale: 2),
        ImageConfig(idiom: .iphone, size: 29, scale: 3),
        ImageConfig(idiom: .iphone, size: 40, scale: 2),
        ImageConfig(idiom: .iphone, size: 40, scale: 3),
        ImageConfig(idiom: .iphone, size: 60, scale: 2),
        ImageConfig(idiom: .iphone, size: 60, scale: 3),
        ImageConfig(idiom: .iphone, size: 20, scale: 2),
        ImageConfig(idiom: .iphone, size: 20, scale: 3),
        ImageConfig(idiom: .ipad, size: 20, scale: 1),
        ImageConfig(idiom: .ipad, size: 20, scale: 2),
        ImageConfig(idiom: .ipad, size: 29, scale: 1),
        ImageConfig(idiom: .ipad, size: 29, scale: 2),
        ImageConfig(idiom: .ipad, size: 40, scale: 1),
        ImageConfig(idiom: .ipad, size: 40, scale: 2),
        ImageConfig(idiom: .ipad, size: 76, scale: 1),
        ImageConfig(idiom: .ipad, size: 76, scale: 2),
        ImageConfig(idiom: .ipad, size: 83.5, scale: 2),
        ImageConfig(idiom: .ios_marketing, size: 1024, scale: 1)
    ]
}

struct ImageConfig {
    var idiom: Devices
    var size: Double
    var scale: Double

    enum Devices: String {
        case iphone
        case ipad
        case ios_marketing = "ios-marketing"
    }
}
