

import UIKit

final class InfoViewController: UIViewController {
  @IBOutlet var largeTitleLabel: UILabel!
  @IBOutlet var title1Label: UILabel!
  @IBOutlet var title2Label: UILabel!
  @IBOutlet var title3Label: UILabel!
  @IBOutlet var headlineLabel: UILabel!
  @IBOutlet var bodyLabel: UILabel!
  @IBOutlet var calloutLabel: UILabel!
  @IBOutlet var subheadLabel: UILabel!
  @IBOutlet var footnoteLabel: UILabel!
  @IBOutlet var caption1Label: UILabel!
  @IBOutlet var caption2Label: UILabel!
  
  private var labelTextStyleTuples:
    [(label: UILabel, textStyle: UIFont.TextStyle)] {
    [(largeTitleLabel, .largeTitle),
     (title1Label, .title1),
     (title2Label, .title2),
     (title3Label, .title3),
     (headlineLabel, .headline),
     (bodyLabel, .body),
     (calloutLabel, .callout),
     (subheadLabel, .subheadline),
     (footnoteLabel, .footnote),
     (caption1Label, .caption1),
     (caption2Label, .caption2)
    ]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func cancelBarButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}
