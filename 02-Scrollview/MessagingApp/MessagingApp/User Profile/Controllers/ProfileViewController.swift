

import UIKit

final class ProfileViewController: UIViewController {
  // MARK: - Properties
  private let profileHeaderView = ProfileHeaderView()
  private let mainStackView = UIStackView()
	private let scrollView = UIScrollView()
	
//	private let scrollViewFrameLayout: UILayoutGuide!
	
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
		
    setupScrollView()
		setupMainStackView()
		
		setFloatButton()
  }
  
  // MARK: - Layouts
  private func setupProfileHeaderView() {
		
		profileHeaderView.translatesAutoresizingMaskIntoConstraints =
			false
		profileHeaderView.heightAnchor.constraint(
			equalToConstant: 360).isActive = true
		mainStackView.addArrangedSubview(profileHeaderView)
		
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
		
  }
	
	private func setupMainStackView() {
		mainStackView.axis = .vertical
		mainStackView.distribution = .equalSpacing
		mainStackView.translatesAutoresizingMaskIntoConstraints =
			false
		
		
		
		
		scrollView.addSubview(mainStackView)
	
		
		let contentLayoutGuide = scrollView.contentLayoutGuide
		
		NSLayoutConstraint.activate([
			mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
			
			mainStackView.leadingAnchor.constraint(equalTo:
				contentLayoutGuide.leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo:
				contentLayoutGuide.trailingAnchor),
			mainStackView.topAnchor.constraint(equalTo:
				contentLayoutGuide.topAnchor),
			
			mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
		])
		
		setupProfileHeaderView()
		setupButtons()
	}
	
	private func setupScrollView() {
		//1
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
		
		let frameLayoutGuide = scrollView.frameLayoutGuide
		
		//2
		NSLayoutConstraint.activate([
			frameLayoutGuide.leadingAnchor.constraint(equalTo:
				view.leadingAnchor),
			frameLayoutGuide.trailingAnchor.constraint(equalTo:
				view.trailingAnchor),
			frameLayoutGuide.topAnchor.constraint(equalTo:
				view.safeAreaLayoutGuide.topAnchor),
			frameLayoutGuide.bottomAnchor.constraint(equalTo:
				view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	private func setFloatButton(){
		
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		button.layer.cornerRadius = 50
		button.setTitle("Settings", for: .normal)
		button.backgroundColor = UIColor.blue
		button.setTitleColor(UIColor.white, for: .normal)
		
		
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)

		
		NSLayoutConstraint.activate([
			button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20),
			button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			
			button.widthAnchor.constraint(equalToConstant: 100),
			button.heightAnchor.constraint(equalTo: button.widthAnchor),
		])
		
	}
}

// MARK: - Buttons Configuration
extension ProfileViewController {
  private func createButton(text: String, color: UIColor = .blue) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 55).isActive = true
    button.setTitle(text, for: .normal)
    button.setTitleColor(color, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
    button.contentHorizontalAlignment = .left
    
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }
  
  @objc private func buttonPressed(_ sender: UIButton) {
    let buttonTitle = sender.titleLabel?.text ?? ""
    let message = "\(buttonTitle) button has been pressed"
    
    let alert = UIAlertController(
      title: "Button Pressed",
      message: message,
      preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  func setupButtons() {
    let buttonTitles = [
      "Share Profile", "Favorites Messages", "Saved Messages",
      "Bookmarks", "History", "Notifications", "Find Friends",
      "Security", "Help", "Logout"]
    
    let buttonStack = UIStackView()
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.alignment = .fill
    buttonStack.axis = .vertical
    buttonStack.distribution = .equalSpacing
    
    buttonTitles.forEach { (buttonTitle) in
      buttonStack.addArrangedSubview(createButton(text: buttonTitle))
    }
    
    mainStackView.addArrangedSubview(buttonStack)
    NSLayoutConstraint.activate([
      buttonStack.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
      buttonStack.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
    ])
  }
}
