
import UIKit

// MARK: - CollectionViewController
final class CollectionViewController: UICollectionViewController {
  // MARK: - Properties
  private let cellIdentifier = "CollectionViewCell"
  private let shapes = Shape.makeShapes(
    shapeNames: [.circle, .square, .star, .oval, .triangle, .hexagon])
  
  // MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewLayout()
  }
  
  // MARK: - Flow Layout
  private func setupCollectionViewLayout() {
		guard let collectionViewLayout =
			collectionView.collectionViewLayout
				as? CollectionViewLayout else { return }
		collectionViewLayout.delegate = self
  }
	
	override func traitCollectionDidChange(
		_ previousTraitCollection: UITraitCollection?
	) {
		super.traitCollectionDidChange(previousTraitCollection)
		guard previousTraitCollection?.preferredContentSizeCategory
			!= traitCollection.preferredContentSizeCategory
			else { return }
		collectionView.collectionViewLayout.invalidateLayout()
	}
  // MARK: - Actions
  @IBAction func cancelBarButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return shapes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellIdentifier, for: indexPath)
      as? CollectionViewCell
      else { fatalError("Failed to dequeued CollectionViewCell.") }
    let shape = shapes[indexPath.item]
    cell.configureCell(shape: shape)
    return cell
  }
}

extension CollectionViewController: CollectionViewLayoutDelegate {
	func collectionView(
		_ collectionView: UICollectionView,
		heightForImageAtIndexPath indexPath: IndexPath
	) -> CGFloat {
		return shapes[indexPath.item].image.size.height
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		labelTextAtIndexPath indexPath: IndexPath
	) -> String {
		return shapes[indexPath.item].shapeName.rawValue
	}
}
