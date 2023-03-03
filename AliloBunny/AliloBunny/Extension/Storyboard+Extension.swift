//
//  ViewController+Extension.swift
//  AliloBunny
//
//  Created by Андрей on 9.9.22.
//

import UIKit

// MARK: - StoryboardsNames
enum StoryboardName: String {
    case main
    var id: String { return rawValue.capitalized }
}

extension UIStoryboard {
    convenience init(name: StoryboardName) {
        self.init(name: name.id, bundle: nil)
    }
    
    func viewController<T: UIViewController>(type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}

