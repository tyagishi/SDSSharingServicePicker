//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2021/06/19
//  © 2021  SmallDeskSoftware
//

import Foundation
import SwiftUI

#if os(iOS)
import UIKit
import LinkPresentation

public struct SDSActivityView: UIViewControllerRepresentable {
    var activityItems:[Any]
    var applicationActivities:[UIActivity]?

    public init(isPresented: Binding<Bool>, activityItems: [Any], applicationActivities:[UIActivity]? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return vc
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        print("SDSActivityView#updateUIViewController")
    }
    
    public typealias UIViewControllerType = UIActivityViewController
}

public final class ShareImage: NSObject, UIActivityItemSource {
    private let title: String
    private let item: UIImage?
    private let itemURL: URL?
    public init(title: String, _ item: UIImage?) {
        self.item = item
        self.title = title
        
        if let data = item?.jpegData(compressionQuality: 1.0) {
            let saveDir = FileManager.default.temporaryDirectory.appendingPathComponent("shareimage.jpg")
            try? data.write(to: saveDir)
            self.itemURL = saveDir
        } else {
            self.itemURL = nil
        }
        
    }
    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return item as Any
    }
    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return activityViewControllerPlaceholderItem(activityViewController)
    }
    
    public func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        if let url = itemURL {
            metadata.iconProvider = NSItemProvider.init(contentsOf: url)
        }
        return metadata
    }
}
#endif
