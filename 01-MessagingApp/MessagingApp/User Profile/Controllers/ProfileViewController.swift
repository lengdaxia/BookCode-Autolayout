

import UIKit

final class ProfileViewController: UIViewController {
	private let profileHeaderView = ProfileHeaderView()
	
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
		
		view.backgroundColor = .white
		setupProfileHeaderView()
  }
	
	
	private func setupProfileHeaderView() {
		// 1
		view.addSubview(profileHeaderView)
		// 2
		profileHeaderView.translatesAutoresizingMaskIntoConstraints =
			false
		

		
		// 3
//		profileHeaderView.leadingAnchor.constraint(
//			equalTo: view.leadingAnchor).isActive = true
//		profileHeaderView.trailingAnchor.constraint(
//			equalTo: view.trailingAnchor).isActive = true
//		profileHeaderView.topAnchor.constraint(
//			equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//		profileHeaderView.bottomAnchor.constraint(
//			lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
//			.isActive = true
		
//		improved api
		NSLayoutConstraint.activate([
			profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			profileHeaderView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}
