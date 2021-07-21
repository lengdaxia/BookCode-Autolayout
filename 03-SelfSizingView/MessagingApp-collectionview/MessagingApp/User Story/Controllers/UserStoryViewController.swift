

import UIKit

final class UserStoryViewController: UIViewController {
  // MARK: - Properties
  private let userStory: UserStory
  private let cellIdentifier = "cellIdentifier"
  private let headerViewIdentifier = "headerViewIdentifier"
  private var currentItemIndex = 0
  
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    return flowLayout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .systemBackground
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    collectionView.bounces = false
    collectionView.register(
      StoryEventCollectionViewCell.self,
      forCellWithReuseIdentifier: cellIdentifier)
		collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewIdentifier)
		
    collectionView.dataSource = self
		collectionView.delegate = self
    return collectionView
  }()
  
  private lazy var swipeDownGesture: UISwipeGestureRecognizer = {
    let swipeGesture = UISwipeGestureRecognizer(
      target: self,
      action: #selector(dismissControllerAction))
    swipeGesture.direction = .down
    return swipeGesture
  }()
  
  // MARK: - Initializers
  init(userStory: UserStory) {
    self.userStory = userStory
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    title = "@\(userStory.username.rawValue)"
    setupNavigationBar()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addGestureRecognizer(swipeDownGesture)
    setupCollectionView()
  }
  
  // MARK: - Scroll View
  
  // MARK: - Layouts
  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate(
      [collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
       collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
       collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
       collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)]
    )
  }
  
  // MARK: UI
  private func setupNavigationBar() {
    let leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel, target: self,
      action: #selector(dismissControllerAction))
    navigationItem.leftBarButtonItem = leftBarButtonItem
  }
  
  // MARK: - Actions
  @objc private func dismissControllerAction() {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true, completion: nil)
    }
  }
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		let contentOffsetX = targetContentOffset.pointee.x
		let scrollViewWidth = scrollView.frame.width
		
		currentItemIndex = Int(contentOffsetX / scrollViewWidth)
	}
	
	private func centerCollectionViewContent() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			// 1
			let x = self.collectionView.frame.width
				* CGFloat(self.currentItemIndex)
			let y: CGFloat = 0
			let contentOffset = CGPoint(x: x, y: y)
			
			// 2
			self.collectionView.setContentOffset(
				contentOffset,animated: false)
		}
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		
		super.viewWillTransition(to: size, with: coordinator)
		
		centerCollectionViewContent()
	}
}

// MARK: - UICollectionViewDataSource
extension UserStoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userStory.events.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StoryEventCollectionViewCell
      else { fatalError("Dequeued unregistered cell") }
    let item = indexPath.item
    let storyEvent = userStory.events[item]
    cell.configureCell(storyEvent: storyEvent)
    cell.backgroundColor = item % 2 == 0 ? .lightGray : .darkGray
    return cell
  }
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

		guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewIdentifier, for: indexPath) as? HeaderCollectionReusableView else { fatalError("error") }

		headerView.configureCell(username: userStory.username)
		return headerView
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserStoryViewController:
	UICollectionViewDelegateFlowLayout {
	// 1
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return collectionView.frame.size
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForHeaderInSection section: Int
	) -> CGSize {
		return collectionView.frame.size
	}
	
	// 2
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		return .zero
	}
	// 3
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
	
	
}
