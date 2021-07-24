
import UIKit

protocol MessageBubbleTableViewCellDelegate {
  func doubleTapForCell(_ cell: MessageBubbleTableViewCell)
}

class MessageBubbleTableViewCell: UITableViewCell {
  var delegate: MessageBubbleTableViewCellDelegate?
  
  @IBOutlet var messageLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let gesture = UITapGestureRecognizer(
      target: self,
      action: #selector(doubleTapped))
    gesture.numberOfTapsRequired = 2
    gesture.cancelsTouchesInView = true
    contentView.addGestureRecognizer(gesture)
  }
  
  override func prepareForReuse() {
    messageLabel.text = ""
  }
  
  @objc func doubleTapped() {
      delegate?.doubleTapForCell(self)
   }
}
