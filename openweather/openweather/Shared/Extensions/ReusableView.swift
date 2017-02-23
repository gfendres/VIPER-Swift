
// https://realm.io/news/appbuilders-natasha-muraschev-practical-protocol-oriented-programming/

import Foundation
import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }
