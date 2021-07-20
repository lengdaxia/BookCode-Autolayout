

import UIKit

final class ProfileHeaderView: UIView {
  // MARK: - Properties
  private let profileImageView = ProfileImageView(borderShape: .squircle)
  private let leftSpacerView = UIView()
  private let rightSpacerView = UIView()
  
  private let fullNameLabel = ProfileNameLabel()
  
  private let messageButton = UIButton.createSystemButton(withTitle: "Message")
  private let callButton = UIButton.createSystemButton(withTitle: "Call")
  private let emailButton = UIButton.createSystemButton(withTitle: "Email")
  
  private lazy var profileImageStackView = UIStackView(arrangedSubviews: [leftSpacerView, profileImageView, rightSpacerView])
  
  private lazy var profileStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [profileImageStackView, fullNameLabel])
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()
  
  private lazy var actionStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [messageButton, callButton, emailButton])
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [profileStackView, actionStackView])
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .groupTableViewBackground
    setupStackView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Layouts
  private func setupStackView() {
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate(
      [stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
       stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
       stackView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 500),
       stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
       stackView.topAnchor.constraint(equalTo: topAnchor, constant: 26),
       
       profileImageView.widthAnchor.constraint(equalToConstant: 120),
       profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
       
       leftSpacerView.widthAnchor.constraint(equalTo: rightSpacerView.widthAnchor)
      ])
    
    profileImageView.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.horizontal)
    profileImageView.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.vertical)
    
    fullNameLabel.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.horizontal)
    fullNameLabel.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.vertical)
    fullNameLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: NSLayoutConstraint.Axis.vertical)
    
    messageButton.setContentCompressionResistancePriority(UILayoutPriority(751), for: NSLayoutConstraint.Axis.horizontal)
  }
}

private extension UIButton {
  static func createSystemButton(withTitle title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    return button
  }
}
