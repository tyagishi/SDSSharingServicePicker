//
//  SDSSharingServiceButton.swift
//
//  Created by : Tomoaki Yagishita on 2021/02/20
//  © 2021  SmallDeskSoftware
//

import Foundation
import AppKit
import SwiftUI

public typealias SharingServiceItemProvider = ()->[Any]
public typealias SharingServicePickerCompletion = (NSSharingService?) -> Void

public struct SDSSharingServicePicker : NSViewRepresentable {
    let itemProvider:SharingServiceItemProvider?
    var completion: SharingServicePickerCompletion?

    public init(itemProvider: SharingServiceItemProvider?, completion: SharingServicePickerCompletion? = nil) {
        self.itemProvider = itemProvider
        self.completion = completion
    }

    public func makeNSView(context: Context) -> NSButton {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: "share")
        //button.frame = CGRect(x: 0, y: 0, width: 230, height: 230)
        //button.isBordered = true
        button.wantsLayer = true
        button.cell?.isBezeled = true
        button.layer?.backgroundColor = NSColor.white.cgColor
        button.layer?.cornerRadius = 5
        button.layer?.borderWidth = 1
        button.layer?.borderColor = .black
        button.layer?.masksToBounds = true
        button.target = context.coordinator
        button.action = #selector(Coordinator.buttonPushed)
        context.coordinator.button = button
        return button
    }
    
    public func updateNSView(_ button: NSButton, context: NSViewRepresentableContext<Self>) {
        button.isEnabled = context.environment.isEnabled
    }
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public class Coordinator:NSObject, NSSharingServicePickerDelegate, NSSharingServiceDelegate {
        let parent: SDSSharingServicePicker
        var button:NSButton?
        
        init(parent: SDSSharingServicePicker) {
            self.parent = parent
        }

        @objc
        func buttonPushed() {
            let picker = NSSharingServicePicker(items: parent.itemProvider?() ?? [])
            guard let button = button else { return } // fool proof
            picker.show(relativeTo: .zero, of: button, preferredEdge: .minY)
        }
        
        public func sharingServicePicker(_ sharingServicePicker: NSSharingServicePicker, didChoose service: NSSharingService?) {
            self.parent.completion?(service)
            sharingServicePicker.delegate = nil
        }
    }
    
    public typealias NSViewType = NSButton
}

