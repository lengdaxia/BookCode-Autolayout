import UIKit

class MessagesViewController: UIViewController {
  private var messages: [Message] = []
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadMessages()
  }

  func loadMessages() {
    messages.append(Message(text: "Hello, it's me", sentByMe: true))
    messages.append(Message(text: "I was wondering if you'll like to meet, to go over this new tutorial I'm working on", sentByMe: true))
    messages.append(Message(text: "I'm in California now, but we can meet tomorrow morning, at your house", sentByMe: false))
    messages.append(Message(text: "Sound good! Talk to you later", sentByMe: true))
    messages.append(Message(text: "Ok :]", sentByMe: false))
  }
}

//MARK: - UITableView Delegate & Data Source
extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let message = messages[indexPath.row]
    
    let cellIdentifier = message.sentByMe ? "RightBubble" : "LeftBubble"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                             for: indexPath) as! MessageBubbleTableViewCell
    cell.messageLabel.text = message.text
    
    return cell
  }
}
