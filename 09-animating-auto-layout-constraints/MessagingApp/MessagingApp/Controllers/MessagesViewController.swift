import UIKit

class MessagesViewController: UIViewController {
  private let toolbarView = ToolbarView()
  private var toolbarViewTopConstraint: NSLayoutConstraint!
  
  private let defaultBackgroundColor = UIColor(
    red: 249/255.0,
    green: 249/255.0,
    blue: 249/255.0,
    alpha: 1)
  private var messages: [Message] = []
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = defaultBackgroundColor
    tableView.backgroundColor = defaultBackgroundColor
    
    loadMessages()
    setupToolbarView()
    
    let gesture = UITapGestureRecognizer(
      target: self,
      action: #selector(hideToolbarView))
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self
    tableView.addGestureRecognizer(gesture)
    
  }
  
  func loadMessages() {
    messages.append(Message(text: "Hello, it's me", sentByMe: true))
    messages.append(Message(text: "I was wondering if you'll like to meet, to go over this new tutorial I'm working on", sentByMe: true))
    messages.append(Message(text: "I'm in California now, but we can meet tomorrow morning, at your house", sentByMe: false))
    messages.append(Message(text: "Sound good! Talk to you later", sentByMe: true))
    messages.append(Message(text: "Ok :]", sentByMe: false))
  }
  
  //2
  private func setupToolbarView() {
    //1
    view.addSubview(toolbarView)

    //2
    toolbarViewTopConstraint =
      toolbarView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: -100)

    toolbarViewTopConstraint.isActive = true

    //3
    toolbarView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: 30).isActive = true
    
    toolbarView.delegate = self
  }
  
  @objc func hideToolbarView() {
    //1
    self.toolbarViewTopConstraint.constant =  -100
    
    //2
    UIView.animate(
      withDuration: 1.0,
      delay: 0.0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 1,
      options: [],
      animations: {
        self.toolbarView.alpha = 0
        self.view.layoutIfNeeded()
    },
    completion: nil)
  }

}

//MARK: - UITableView Delegate & Data Source
extension MessagesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //1
    let message = messages[indexPath.row]
    
    //2
    let cellIdentifier = message.sentByMe ? "RightBubble" : "LeftBubble"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                             for: indexPath) as! MessageBubbleTableViewCell
    cell.messageLabel.text = message.text
    cell.backgroundColor = defaultBackgroundColor
    cell.delegate = self
    return cell
  }
}

extension MessagesViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldReceive touch: UITouch
  ) -> Bool {
    return touch.view == tableView
  }
}
extension MessagesViewController: MessageBubbleTableViewCellDelegate {
  func doubleTapForCell(_ cell: MessageBubbleTableViewCell) {
    //1
    guard let indexPath = self.tableView.indexPath(for: cell)
      else { return }
    let message = messages[indexPath.row]
    guard message.sentByMe == false else { return }

    //2
    toolbarViewTopConstraint.constant = cell.frame.midY

    //3
    toolbarView.alpha = 0.95

    //4
    toolbarView.update(
      isLiked: message.isLiked,
      isFavorited: message.isFavorited)
    
    //5
    toolbarView.tag = indexPath.row

    //6
    UIView.animate(
      withDuration: 1.0,
      delay: 0.0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 1,
      options: [],
      animations: {
        self.view.layoutIfNeeded()
      },
      completion: nil)
  }
}

extension MessagesViewController: ToolbarViewDelegate {
  func toolbarView(
    _ toolbarView: ToolbarView,
    didFavoritedWith tag: Int
  ) {
    messages[tag].isFavorited.toggle()
  }
  
  func toolbarView(
    _ toolbarView: ToolbarView,
    didLikedWith tag: Int
  ) {
    messages[tag].isLiked.toggle()
  }
}
