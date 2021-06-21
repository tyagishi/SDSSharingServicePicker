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

public struct SDSActivityView: UIViewControllerRepresentable {
    //var vc: UIActivityViewController? = nil
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
//        uiViewController.title = "updated"
//        uiViewController.userActivity
//        vc = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    public typealias UIViewControllerType = UIActivityViewController
}
#endif
