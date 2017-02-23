
//  https://realm.io/news/appbuilders-natasha-muraschev-practical-protocol-oriented-programming/

import Foundation
import UIKit

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
    
    let Nib = UINib(nibName: T.NibName, bundle: nil)
    register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    return cell
  }
}
