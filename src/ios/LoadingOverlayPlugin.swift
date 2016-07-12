//
//  LoadingOverlayPlugin.swift
//  LoadingOverlayPlugin
//
//  Created by James Hunter on 11/07/2016.
//  Copyright (c) 2016 JADH. All rights reserved.
//

import UIKit

@objc(LoadingOverlayPlugin) class LoadingOverlayPlugin: CDVPlugin {
    
    var command = CDVInvokedUrlCommand()
    var overlay: UIView?
    
    func show(command: CDVInvokedUrlCommand) {
        self.command = command
        
        let title = command.argumentAtIndex(0) as? String
        let message = command.argumentAtIndex(1) as? String
        
        if let parentView = self.webView.superview,
           let overlayMessage = message {
            let view = RoundUpLoadingOverlay(message: overlayMessage, frame: parentView.frame)
            
            self.overlay = view
            view.alpha = 0.0
            parentView.addSubview(view)

            UIView.animateWithDuration(0.5, animations: { [weak view] in
                view?.alpha = 1.0
            }, completion: { [unowned self] (_) in
                let result = CDVPluginResult(status: CDVCommandStatus_OK)
                self.commandDelegate.sendPluginResult(result, callbackId: self.command.callbackId)
            })
        } else {
            print("BAD")
        }
    }
    
    func hide(command: CDVInvokedUrlCommand) {
        self.command = command
        
        if let loadingOverlay = overlay {
            UIView.animateWithDuration(0.5, animations: { [weak loadingOverlay] in
                loadingOverlay?.alpha = 0.0
            }, completion: { [unowned self] _ in
                loadingOverlay.removeFromSuperview()
                self.overlay = nil
            })
        }
    }
}

class RoundUpLoadingOverlay: UIVisualEffectView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    
    convenience init(message: String, frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .Dark)
        self.init(frame: frame)
        self.effect = blurEffect

        let label = UILabel()
        label.text = message
        label.textColor = UIColor.whiteColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFontOfSize(20.0)
        label.textAlignment = .Center
        self.addSubview(label)

        let labelCentreConstraint = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let labelTopConstraint = NSLayoutConstraint(item: label, attribute: .TopMargin, relatedBy: .Equal, toItem: self, attribute: .TopMargin, multiplier: 1.0, constant: 100)
        let labelLeftConstraint = NSLayoutConstraint(item: label, attribute: .LeftMargin, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 20.0)
        let labelRightConstraint = NSLayoutConstraint(item: label, attribute: .RightMargin, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 20.0)

        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)

        let spinnerCentreXConstraint = NSLayoutConstraint(item: spinner, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let spinnerCentreYConstraint = NSLayoutConstraint(item: spinner, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)

        NSLayoutConstraint.activateConstraints([labelCentreConstraint, labelTopConstraint, labelLeftConstraint, labelRightConstraint, spinnerCentreXConstraint, spinnerCentreYConstraint])

        spinner.startAnimating()
    }
}
