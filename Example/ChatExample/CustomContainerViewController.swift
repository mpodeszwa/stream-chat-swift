import UIKit

class CustomContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomChatNavVC")
        view.addSubview(navVC.view)
        addChild(navVC)
        navVC.didMove(toParent: self)
        navVC.view.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
    }

}
