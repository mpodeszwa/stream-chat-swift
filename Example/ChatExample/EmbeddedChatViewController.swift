import UIKit
//import StreamChat

class EmbeddedChatViewController: UIViewController {

    lazy var chat = CustomChatViewController()
    lazy var topConstraint = { chat.view.topAnchor.constraint(equalTo: view.topAnchor) }()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        addChild(chat)
        chat.didMove(toParent: self)
        view.addSubview(chat.view)
        chat.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chat.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            chat.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            topConstraint,
            chat.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
