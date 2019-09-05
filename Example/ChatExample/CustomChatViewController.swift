//
//  CustomChatViewController.swift
//  StreamChat
//
//  Created by Alexey Bukhtin on 28/06/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChatCore
import StreamChat
import RxSwift

var disposeBag2 = DisposeBag()

class CustomChatViewController: ChatViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Client.shared.set(user: .user2, token: .token2)
        let channel = Channel(id: "general", name: "General")
        channelPresenter = ChannelPresenter(channel: channel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disposeBag2 = DisposeBag()
        Client.shared.onEvent(.messageNew).subscribe(onNext: { event in
            print(event)
        }).disposed(by: disposeBag2)
    }

    override func messageCell(at indexPath: IndexPath, message: Message, readUsers: [User]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message")
            ?? UITableViewCell(style: .value2, reuseIdentifier: "message")

        cell.textLabel?.text = message.user.name
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        cell.detailTextLabel?.text = message.text
        cell.detailTextLabel?.numberOfLines = 0

        return cell
    }

    override func loadingCell(at indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loading")
            ?? UITableViewCell(style: .default, reuseIdentifier: "loading")

        cell.textLabel?.textColor = .red
        cell.textLabel?.text = "LOADING..."
        cell.textLabel?.textAlignment = .center

        return cell
    }

    override func statusCell(at indexPath: IndexPath,
                             title: String,
                             subtitle: String? = nil,
                             highlighted: Bool) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "status")
            ?? UITableViewCell(style: .default, reuseIdentifier: "status")

        cell.textLabel?.textColor = .gray
        cell.textLabel?.text = title
        cell.textLabel?.textAlignment = .center

        return cell
    }
}
