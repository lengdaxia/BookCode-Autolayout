

import UIKit

final class MessagesViewController: UIViewController {
  // MARK: - Properties
  private let userStories = [
    UserStory(username: .swift),
    UserStory(username: .android),
    UserStory(username: .dog)]
  
  private lazy var miniStoryView = MiniStoryView(userStories: userStories)
  
  // MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupMiniStoryView()
  }
  
  // MARK: - Layouts
  private func setupMiniStoryView() {
    view.addSubview(miniStoryView)
    miniStoryView.backgroundColor = .lightGray
    miniStoryView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [miniStoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
       miniStoryView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
       miniStoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       miniStoryView.heightAnchor.constraint(equalToConstant: 180)]
    )
    miniStoryView.delegate = self
  }
  
}

// MARK: - MiniStoryViewDelegate
extension MessagesViewController: MiniStoryViewDelegate {
  func didSelectUserStory(atIndex index: Int) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      let userStory = self.userStories[index]
      let viewController = UserStoryViewController(userStory: userStory)
      let navigationController = UINavigationController(
        rootViewController: viewController)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: true)
    }
  }
}
