//
//  main.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/01/25.
//

import Foundation
import ArgumentParser
import AppKit

struct ResizeMachine: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "ResizeMachine",
        abstract: "Resizes .png file and generates Appicon file",
        discussion:
            """
ddddd
""",
        version: "0.1.0",
        shouldDisplay: true,
//        subcommands: ,
//        defaultSubcommand: ,
        helpNames: [.long, .short])
    
    @Argument(help: "An .png file to be used for the Appicon file")
    var iconFile: String
    
    func readImageFile() {
        let currentPath = "file://" + FileManager.default.currentDirectoryPath + "/"
        let url = URL(string:currentPath  + iconFile)!
        print(url)
        
        do {
            let readData = try Data(contentsOf: url)
            let image = NSImage(data: readData)
            let resizedOne = image?.resized(to: NSSize(width: 100, height: 100))
            do {
                try resizedOne?.png?.write(to: URL(string: currentPath + "resizedOne.png")!)
            } catch let error {
                print(error)
            }
            let resizedTwo = image?.resized(to: NSSize(width: 200, height: 200))
            do {
                try resizedTwo?.png?.write(to: URL(string: currentPath + "resizedTwo.png")!)
            } catch let error {
                print(error)
            }
            print("read successfully: \(url)")
        } catch let error {
            print(error)
        }
    }
    
    func run() throws {
        print("Hello, World!")
        readImageFile()
    }
}

ResizeMachine.main()

extension NSBitmapImageRep {
    func imageWithFormat(for format: NSBitmapImageRep.FileType) -> Data? {
        return representation(using: format, properties: [:])
    }
}

extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}

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
