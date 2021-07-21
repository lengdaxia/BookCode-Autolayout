
import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
  // MARK: - Properties
  private let label: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 26)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let topSpacerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let bottomSpacerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [topSpacerView, imageView, label, bottomSpacerView])
    stackView.axis = .vertical
    return stackView
  }()
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    backgroundColor = .white
    setupStackView()
  }
  
  // MARK: - Layouts
  private func setupStackView() {
		addSubview(stackView)
		
		stackView.fillSuperView()
		NSLayoutConstraint.activate(
			[topSpacerView.heightAnchor.constraint(
				equalTo: bottomSpacerView.heightAnchor)]
		)
  }
  
  // MARK: - User Interface
  func configureCell(username: UserStory.Username) {
    label.text = "\(username.rawValue.capitalized)\nStories"
    imageView.image = UIImage(named: username.rawValue)
  }
}
