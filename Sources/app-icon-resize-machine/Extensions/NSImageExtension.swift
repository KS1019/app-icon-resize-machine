//
//  NSImageExtension.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/07.
//

import Foundation
import AppKit

extension NSImage {
    func resized(to newSize: Int) -> NSImage? {
        guard let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil, pixelsWide: newSize, pixelsHigh: newSize,
            bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
            colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0
        ) else { return nil }

        bitmapRep.size = NSSize(width: newSize, height: newSize)
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
        draw(in: NSRect(x: 0, y: 0, width: newSize, height: newSize), from: .zero, operation: .copy, fraction: 1.0)
        NSGraphicsContext.restoreGraphicsState()
        
        let resizedImage = NSImage(size: NSSize(width: newSize, height: newSize))
        resizedImage.addRepresentation(bitmapRep)
        return resizedImage
    }
    var png : Data? { tiffRepresentation?.bitmapImageRep?.converted(to: .png) }
}
