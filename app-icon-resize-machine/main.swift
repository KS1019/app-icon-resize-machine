//
//  main.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/01/25.
//

import Foundation
import ArgumentParser
import AppKit

var basePNGFile: NSImage?
var resizedPNGFiles: [NSImage]
var imagesJSON: [Image] = []

let currentPath = "file://" + FileManager.default.currentDirectoryPath + "/"

struct ResizeMachine: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "ResizeMachine",
        abstract: "Resizes .png file and generates Appicon file",
        discussion: "This command takes .png file as an input and outptus .appicon file",
        version: "0.1.0",
        shouldDisplay: true,
        helpNames: [.long, .short])
    
    @Option(help: "An .png file to be used for the Appicon file", completion: .file())
    var iconFileName: String
    
    @Option(help: "App name to be used in names of icon files")
    var appName: String?
    
    @Option(help: "Name to be used as an author")
    var authorName: String?

    func createDir() {
        let finalFilePath = currentPath + (appName ?? "App") + ".appiconset"
        do {
            try FileManager.default.createDirectory(at: URL(string: finalFilePath)!,
                                                    withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("Error : \(error)")
        }
    }
    
    func write(contents: Contents, to: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encoded = try! encoder.encode(contents)
        try! encoded.write(to: to)
    }
    
    func writeJSON() {
        let contents = Contents(images: imagesJSON, info: Info(version: 1, author: authorName ?? "App"))
        write(contents: contents, to: URL(string: currentPath + "\(appName ?? "App").appiconset/" + "Contents.json")!)
    }
    
    func createResizeImages() {
        let imageConfig = ImageGen(appName: (appName ?? ""), authorName: (authorName ?? ""))
        for config in imageConfig.imageConfigs {
            let size = config.size * config.scale
            guard let resized = basePNGFile?.resized(to: Int(size)) else { print("Error");return }
            var sizeAtrr: String
            let scaleStr = String(format: "%.0f", config.scale)
            let sizeStr = String(format: "%.0f", config.size)
            var filename: String
            if (config.size.truncatingRemainder(dividingBy: 1) == 0) {
                sizeAtrr = "\(sizeStr)x\(sizeStr)" + "@\(scaleStr)x"
                filename = "Icon-App-" + sizeAtrr + ".png"
                imagesJSON.append(Image(idiom: config.idiom.rawValue,
                                        size: "\(sizeStr)x\(sizeStr)",
                                        scale: "\(scaleStr)x",
                                        filename: filename))
            } else {
                sizeAtrr = "\(config.size)x\(config.size)" + "@\(scaleStr)x"
                filename = "Icon-App-" + sizeAtrr + ".png"
                imagesJSON.append(Image(idiom: config.idiom.rawValue,
                                        size: "\(config.size)x\(config.size)",
                                        scale: "\(scaleStr)x",
                                        filename: filename))
            }
            do {
                try resized.png?.write(to: URL(string: currentPath + "\(appName ?? "App").appiconset/" + filename)!)
            } catch let error {
                print(error)
            }
        }
    }
    
    func run() throws {
        basePNGFile = NSImage(contentsOf: URL(string: currentPath + iconFileName)!)
        createDir()
        createResizeImages()
        writeJSON()
    }
}

ResizeMachine.main()
