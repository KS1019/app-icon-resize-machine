//
//  main.swift
//  app-icon-resize-machine
//
//  Created by Kotaro Suto on 2021/01/25.
//

import Foundation
import ArgumentParser

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
    
    func run() throws {
        print("Hello, World!")
    }
}

ResizeMachine.main()
