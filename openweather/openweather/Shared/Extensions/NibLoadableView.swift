
// https://realm.io/news/appbuilders-natasha-muraschev-practical-protocol-oriented-programming/

import Foundation
import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
  
  static var NibName: String {
    return String(describing: self)
  }
}

extension UICollectionViewCell: NibLoadableView { }
extension UITableViewCell: NibLoadableView { }
