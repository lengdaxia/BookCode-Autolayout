import UIKit

final class CollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 8
    layer.masksToBounds = true
  }
  
  func configureCell(shape: Shape) {
    label.text = shape.shapeName.rawValue.capitalized
    imageView.image = shape.image
  }
}
