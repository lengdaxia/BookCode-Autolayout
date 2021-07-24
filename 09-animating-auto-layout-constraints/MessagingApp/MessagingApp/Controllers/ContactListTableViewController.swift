import UIKit

class ContactListTableViewController: UITableViewController {
  private var contacts: [Contact] = []
  private let cellIdentififer = "ContactCell"
  @IBOutlet var contactPreviewView: ContactPreviewView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contacts.append(Contact(name: "John Doe", photo: "rw-logo"))
    contacts.append(Contact(name: "Jane Doe", photo: "rw-logo"))
    contacts.append(Contact(name: "Joseph Doe", photo: "rw-logo"))
    
    configureGestures()
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //1
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentififer, for: indexPath) as! ContactTableViewCell
    
    //2
    let contact = contacts[indexPath.row]
    cell.nameLabel.text = contact.name
    
    return cell
  }
  
  // MARK: - Setuo Contact Preview
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    //1
    let contact = contacts[indexPath.row]
    
    //2
    contactPreviewView.nameLabel.text = contact.name
    contactPreviewView.photoImageView.image = UIImage(named: contact.photo)
    
    //3
    view.addSubview(contactPreviewView)
    
    //4
    contactPreviewView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contactPreviewView.widthAnchor.constraint(equalToConstant: 150),
      contactPreviewView.heightAnchor.constraint(equalToConstant: 150),
      contactPreviewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      contactPreviewView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
    
    //5
    contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    contactPreviewView.alpha = 0
    
    //6
    UIView.animate(withDuration: 0.3) {
      self.contactPreviewView.alpha = 1
      self.contactPreviewView.transform = CGAffineTransform.identity
    }
  }
  
  private func configureGestures() {
    //1
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideContactPreview))
    
    //2
    contactPreviewView.addGestureRecognizer(tapGesture)
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func hideContactPreview() {
    //1
    UIView.animate(withDuration: 0.3, animations: {
      self.contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
      self.contactPreviewView.alpha = 0
    }) { (success) in
      //2
      self.contactPreviewView.removeFromSuperview()
    }
  }
}
