//
//  DataExtension.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/07.
//

import Foundation
import AppKit

extension Data {
    var bitmapImageRep: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
