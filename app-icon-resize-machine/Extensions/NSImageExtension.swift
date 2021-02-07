//
//  NSImageExtension.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/02/07.
//

import Foundation
import AppKit

extension NSImage {
    func resized(to newSize: NSSize) -> NSImage? {
        if let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil, pixelsWide: Int(newSize.width), pixelsHigh: Int(newSize.height),
            bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
            colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0
        ) {
            bitmapRep.size = newSize
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
            draw(in: NSRect(x: 0, y: 0, width: newSize.width, height: newSize.height), from: .zero, operation: .copy, fraction: 1.0)
            NSGraphicsContext.restoreGraphicsState()
            
            let resizedImage = NSImage(size: newSize)
            resizedImage.addRepresentation(bitmapRep)
            return resizedImage
        }
        
        return nil
    }
    
    var png : Data? { tiffRepresentation?.bitmap?.imageWithFormat(for: .png)  }
    var jpeg: Data? { tiffRepresentation?.bitmap?.imageWithFormat(for: .jpeg) }
    var gif : Data? { tiffRepresentation?.bitmap?.imageWithFormat(for: .gif)  }
}
