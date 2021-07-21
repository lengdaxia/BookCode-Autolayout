import UIKit

class MessagesTableViewController: UITableViewController {
  private var messages = Message.fetchAll()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Messages"
    
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.allowsSelection = false
		tableView.rowHeight = UITableView.automaticDimension
		
    tableView.register(
      RightMessageBubbleTableViewCell.self,
      forCellReuseIdentifier: MessageBubbleCellType.rightText.rawValue)
    tableView.register(
      LeftMessageBubbleTableViewCell.self,
      forCellReuseIdentifier: MessageBubbleCellType.leftText.rawValue)
    tableView.separatorStyle = .none
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let message = messages[indexPath.row]
    
    //1
    var cell: MessageBubbleTableViewCell
    if message.sentByMe {
      cell = tableView.dequeueReusableCell(
        withIdentifier: MessageBubbleCellType.rightText.rawValue,
        for: indexPath) as! RightMessageBubbleTableViewCell
    }
    else {
      cell = tableView.dequeueReusableCell(
        withIdentifier: MessageBubbleCellType.leftText.rawValue,
        for: indexPath) as! LeftMessageBubbleTableViewCell
    }
    
		cell.messageLabel.text = message.text
    
    return cell
  }
}
