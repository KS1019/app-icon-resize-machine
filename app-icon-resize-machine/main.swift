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
        discussion: "This command takes .png file as an input and outptus .appicon file",
        version: "0.1.0",
        shouldDisplay: true,
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
    
    func readAndWriteJSON() {
        print("Starting \(#function)")

        let data = """
{
    "images":[
        {
            "idiom":"iphone",
            "size":"20x20",
            "scale":"2x",
            "filename":"Icon-App-20x20@2x.png"
        },
        {
            "idiom":"iphone",
            "size":"20x20",
            "scale":"3x",
            "filename":"Icon-App-20x20@3x.png"
        },
        {
            "idiom":"iphone",
            "size":"29x29",
            "scale":"1x",
            "filename":"Icon-App-29x29@1x.png"
        },
        {
            "idiom":"iphone",
            "size":"29x29",
            "scale":"2x",
            "filename":"Icon-App-29x29@2x.png"
        },
        {
            "idiom":"iphone",
            "size":"29x29",
            "scale":"3x",
            "filename":"Icon-App-29x29@3x.png"
        },
        {
            "idiom":"iphone",
            "size":"40x40",
            "scale":"2x",
            "filename":"Icon-App-40x40@2x.png"
        },
        {
            "idiom":"iphone",
            "size":"40x40",
            "scale":"3x",
            "filename":"Icon-App-40x40@3x.png"
        },
        {
            "idiom":"iphone",
            "size":"60x60",
            "scale":"2x",
            "filename":"Icon-App-60x60@2x.png"
        },
        {
            "idiom":"iphone",
            "size":"60x60",
            "scale":"3x",
            "filename":"Icon-App-60x60@3x.png"
        },
        {
            "idiom":"iphone",
            "size":"76x76",
            "scale":"2x",
            "filename":"Icon-App-76x76@2x.png"
        },
        {
            "idiom":"ipad",
            "size":"20x20",
            "scale":"1x",
            "filename":"Icon-App-20x20@1x.png"
        },
        {
            "idiom":"ipad",
            "size":"20x20",
            "scale":"2x",
            "filename":"Icon-App-20x20@2x.png"
        },
        {
            "idiom":"ipad",
            "size":"29x29",
            "scale":"1x",
            "filename":"Icon-App-29x29@1x.png"
        },
        {
            "idiom":"ipad",
            "size":"29x29",
            "scale":"2x",
            "filename":"Icon-App-29x29@2x.png"
        },
        {
            "idiom":"ipad",
            "size":"40x40",
            "scale":"1x",
            "filename":"Icon-App-40x40@1x.png"
        },
        {
            "idiom":"ipad",
            "size":"40x40",
            "scale":"2x",
            "filename":"Icon-App-40x40@2x.png"
        },
        {
            "idiom":"ipad",
            "size":"76x76",
            "scale":"1x",
            "filename":"Icon-App-76x76@1x.png"
        },
        {
            "idiom":"ipad",
            "size":"76x76",
            "scale":"2x",
            "filename":"Icon-App-76x76@2x.png"
        },
        {
            "idiom":"ipad",
            "size":"83.5x83.5",
            "scale":"2x",
            "filename":"Icon-App-83.5x83.5@2x.png"
        },
        {
          "size" : "1024x1024",
          "idiom" : "ios-marketing",
          "scale" : "1x",
          "filename" : "ItunesArtwork@2x.png"
        }
    ],
    "info":{
        "version":1,
        "author":"makeappicon"
    }
}
""".data(using: .utf8)!
        print("data:\n\(data)")
        var json = try! JSONDecoder().decode(Contents.self, from: data)
        json.info.author = "Kotaro Suto"
        json.info.version += 1
        print("Ending \(#function)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encoded = try! encoder.encode(json)
        let currentPath = "file://" + FileManager.default.currentDirectoryPath + "/"
        try! encoded.write(to: URL(string: currentPath + "test")!)
    }
    
    func run() throws {
        print("Hello, World!")
        //readImageFile()
        readAndWriteJSON()
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
