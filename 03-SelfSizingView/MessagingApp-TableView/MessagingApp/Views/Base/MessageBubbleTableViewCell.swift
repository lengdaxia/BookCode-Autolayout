

import UIKit

enum MessageBubbleCellType: String {
  case rightText
  case leftText
}

class MessageBubbleTableViewCell: UITableViewCell {
  public let greenBubbleImageName = "green-bubble"
	public let blueBubbleImageName = "blue-bubble"
  
  lazy var messageLabel: UILabel = {
    let messageLabel = UILabel(frame: .zero)
    messageLabel.textColor = .white
    messageLabel.font = UIFont.systemFont(ofSize: 13)
    messageLabel.numberOfLines = 0
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    return messageLabel
  }()
  
  internal var bubbleImageView: UIImageView = {
    let bubbleImageView = UIImageView(frame: .zero)
    bubbleImageView.contentMode = .scaleToFill
    bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
    return bubbleImageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureLayout()
  }
  
  func configureBubbleImage(imageName: String, insets: UIEdgeInsets) {
    //1
    let image = UIImage(named: imageName)!
    
    //2
    bubbleImageView.image = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }
  
  func configureLayout() {
		
		contentView.addSubview(bubbleImageView)
    contentView.addSubview(messageLabel)
    
//    NSLayoutConstraint.activate([
//      //1
//      messageLabel.topAnchor.constraint(
//        equalTo: contentView.topAnchor,
//        constant: 10),
//      
//      messageLabel.rightAnchor.constraint(
//        equalTo: contentView.rightAnchor,
//        constant: -10),
//      
//      messageLabel.bottomAnchor.constraint(
//        equalTo: contentView.bottomAnchor,
//        constant: -10),
//      
//      messageLabel.leftAnchor.constraint(
//        equalTo: contentView.leftAnchor,
//        constant: 10)
//    ])
     
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }
}
