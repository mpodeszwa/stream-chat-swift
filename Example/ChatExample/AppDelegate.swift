//
//  AppDelegate.swift
//  StreamChat
//
//  Created by Alexey Bukhtin on 29/03/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatCore
import RxSwift
import RxCocoa

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Client.config = .init(apiKey: "qk4nn7rpcn75", logOptions: .all)
        Client.shared.set(user: .user2, token: .token2)
        setupNotifications()
        return true
    }
    
    private func setupNotifications() {
        Notifications.shared.askForPermissionsIfNeeded()
        
        Notifications.shared.openNewMessage = { [weak self] messageId, channelId in
            if let tabBarController = self?.window?.rootViewController as? UITabBarController,
                let navigationViewController = tabBarController.viewControllers?.first as? UINavigationController,
                let channelsViewController = navigationViewController.viewControllers.first as? ChannelsViewController,
                let channelIndex = channelsViewController.items.firstIndex(whereChannelId: channelId),
                let channelPresenter = channelsViewController.items[channelIndex].channelPresenter {
                channelsViewController.navigationController?.viewControllers = [channelsViewController]
                let chatViewController = channelsViewController.createChatViewController(with: channelPresenter,
                                                                                         indexPath: .row(channelIndex))
                channelsViewController.show(chatViewController: chatViewController)
            }
        }
    }
}

// MARK: - Test Data
    
extension User {
    static let user1 = User(id: "broken-waterfall-5", name: "Jon Snow", avatarURL: URL(string: "https://bit.ly/2u9Vc0r"))
    static let user2 = User(id: "noisy-mountain-3", name: "Noisy mountain")
}

extension Token {
    static let token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiYnJva2VuLXdhdGVyZmFsbC01In0.d1xKTlD_D0G-VsBoDBNbaLjO-2XWNA8rlTm4ru4sMHg"
    static let token2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibm9pc3ktbW91bnRhaW4tMyJ9.GAhzrzo8SsDn_RGzX4Fob5bZB0nKXXPKya8okbr9WB0"
}
