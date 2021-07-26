

import UIKit

protocol CollectionViewLayoutDelegate: class {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForImageAtIndexPath indexPath: IndexPath)
    -> CGFloat
  func collectionView(
    _ collectionView: UICollectionView,
    labelTextAtIndexPath indexPath: IndexPath)
    -> String
}

final class CollectionViewLayout: UICollectionViewLayout {
	// 1
	weak var delegate: CollectionViewLayoutDelegate?
	// 2
	private var columns: Int {
		return UIDevice.current.orientation ==
			.portrait ? 1 : 2
	}
	// 3
	private let cellPadding: CGFloat = 8
	// 4
	private var contentWidth: CGFloat = 0
	private var contentHeight: CGFloat = 0
	// 5
	private var contentBounds: CGRect {
		let origin: CGPoint = .zero
		let size = CGSize(
			width: contentWidth,
			height: contentHeight)
		return CGRect(origin: origin, size: size)
	}
	// 6
	private var cachedLayoutAttributes:
		[UICollectionViewLayoutAttributes] = []
	
  private func makeAttributes(for collectionView: UICollectionView) {
		// 1
		guard let delegate = delegate else { return }
		let itemWidth = contentWidth / CGFloat(columns)
		// 2
		var xOffsets: [CGFloat] = []
		(0..<columns).forEach {
			xOffsets.append(CGFloat($0) * itemWidth)
		}
		// 3
		var column = 0
		// 4
		var yOffsets = [CGFloat](repeating: 0, count: columns)
		// 5
		let items = 0..<collectionView.numberOfItems(inSection: 0)
		
		for item in items {
			// 1
			let indexPath = IndexPath(item: item, section: 0)
			// 2
			let itemHeight = makeItemHeight(
				atIndexPath: indexPath,
				itemWidth: itemWidth,
				withCollectionView: collectionView,
				delegate: delegate)
			// 3
			let frame = CGRect(
				x: xOffsets[column],
				y: yOffsets[column],
				width: itemWidth,
				height: itemHeight)
			// 4
			let insetFrame = frame.insetBy(
				dx: cellPadding,
				dy: cellPadding)
			// 5
			let layoutAttributes =
				UICollectionViewLayoutAttributes(
					forCellWith: indexPath)
			layoutAttributes.frame = insetFrame
			cachedLayoutAttributes.append(layoutAttributes)
			// 6
			contentHeight = max(contentHeight, frame.maxY)
			// 7
			yOffsets[column] += itemHeight
			// 8
			column = column < columns - 1 ? column + 1 : 0
		}
  }
  
  private func makeItemHeight(
    atIndexPath indexPath: IndexPath,
    itemWidth: CGFloat,
    withCollectionView collectionView: UICollectionView,
    delegate: CollectionViewLayoutDelegate) -> CGFloat {
		// 1
		let imageHeight = delegate.collectionView(
			collectionView,
			heightForImageAtIndexPath: indexPath)
		// 2
		let labelText = delegate.collectionView(
			collectionView,
			labelTextAtIndexPath: indexPath)
		let maxLabelHeightSize = CGSize(
			width: itemWidth,
			height: CGFloat.greatestFiniteMagnitude)
		let boundingRect = labelText.boundingRect(
			with: maxLabelHeightSize,
			options: [.usesLineFragmentOrigin],
			attributes:
				[NSAttributedString.Key.font:
				 UIFont.preferredFont(forTextStyle: .headline)],
			context: nil)
		let labelHeight = ceil(boundingRect.height)
		// 3
		let itemHeight = cellPadding * 2 + imageHeight + labelHeight
		return itemHeight
  }
	
	override func prepare() {
		super.prepare()
		
		// 1
			guard let collectionView = collectionView
				else { return }
			cachedLayoutAttributes.removeAll()
			// 2
			let size = collectionView.bounds.size
			let safeAreaContentInset = collectionView.safeAreaInsets
			collectionView.contentInsetAdjustmentBehavior = .always
			contentWidth = size.width -
				safeAreaContentInset.horizontalInsets
			contentHeight = size.height -
				safeAreaContentInset.verticalInsets
			// 3
			makeAttributes(for: collectionView)
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return cachedLayoutAttributes[indexPath.item]
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
			return cachedLayoutAttributes.filter {  rect.intersects($0.frame)
		}
	}
	
	// 1
	override var collectionViewContentSize: CGSize {
		return contentBounds.size
	}
	// 2
	override func shouldInvalidateLayout(
		forBoundsChange newBounds: CGRect) -> Bool {
		guard let collectionView = collectionView
			else { return false }
		return newBounds.size
			!= collectionView.bounds.size
	}
}

// MARK: - UIEdgeInsets
private extension UIEdgeInsets {
  var horizontalInsets: CGFloat {
    return left + right
  }
  
  var verticalInsets: CGFloat {
    return top + bottom
  }
}
