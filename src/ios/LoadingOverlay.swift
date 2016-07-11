//
//  LoadingOverlay.swift
//  LoadingOverlay
//
//  Created by James Hunter on 11/07/2016.
//  Copyright (c) 2016 JADH. All rights reserved.
//

import UIKit

@objc(LoadingOverlay) class LoadingOverlay: CDVPlugin {
    
    var command = CDVInvokedUrlCommand()
    
    func show(command: CDVInvokedUrlCommand) {
        self.command = command
        
        let title = command.argumentAtIndex(1) as? String
        let message = command.argumentAtIndex(1) as? String
    }
    
    func hide(command: CDVInvokedUrlCommand) {
        self.command = command
    }
}
