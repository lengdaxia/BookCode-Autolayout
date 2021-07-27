import UIKit

class TaskTableViewCell: UITableViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    setupConstrainsts()
  }
  
  private func setupConstrainsts() {
    contentView.addSubview(taskNameLabel)
    contentView.addSubview(favoriteButton)
    
    taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
    favoriteButton.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
			favoriteButton.leadingAnchor.constraint(
					equalTo: contentView.leadingAnchor,
					constant: 20),
				favoriteButton.centerYAnchor.constraint(
					equalTo: contentView.centerYAnchor),
				
				taskNameLabel.leadingAnchor.constraint(
					equalTo: favoriteButton.trailingAnchor,
					constant: 20),
				taskNameLabel.trailingAnchor.constraint(
					lessThanOrEqualTo: contentView.trailingAnchor,
					constant: -20),
				taskNameLabel.centerYAnchor.constraint(
					equalTo: contentView.centerYAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  lazy var favoriteButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "star-icon"), for: .normal)
    return button
  }()
  
  lazy var taskNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    label.numberOfLines = 0
    
    return label
  }()

  func configure(_ task: Task){
    taskNameLabel.text = task.name
    accessoryType = task.isDone ? .checkmark : .none
    let image = task.isFavorited ? "star-icon" : "star-icon-filled"
    favoriteButton.setImage(UIImage(named: image), for: .normal)
  }
}
