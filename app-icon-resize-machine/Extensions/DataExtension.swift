//
//  DataExtension.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/07.
//

import Foundation

extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
