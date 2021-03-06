//
//  NSBitmapImageRepExtension.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/07.
//

import Foundation
import AppKit

extension NSBitmapImageRep {
    func converted(to format: NSBitmapImageRep.FileType) -> Data? {
        return representation(using: format, properties: [:])
    }
}
