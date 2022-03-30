//
//  Utility.swift
//  News
//
//  Created by Anjaneyulu Battula on 28/03/22.
//

import Foundation
import UIKit

final class Utility {
    static var shared = Utility()

    private init() {

    }

    func showLoader(viewController: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: "Loading Details...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func hideLoader(viewController: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            viewController.dismiss(animated: false, completion: nil)
        }
    }

    func showAlert(viewController: UIViewController, msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
            let defaultAction = UIAlertAction(
                   title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

extension Date {
    public var removeTimeStamp : Date? {
       guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
        return nil
       }

        return date

        //Added for testing
//        let resultDate = Calendar.current.date(byAdding: .hour, value: -8, to: date)
//        return resultDate
   }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension UIViewController {

    var isPresentingForFirstTime: Bool {
        return isBeingPresented || isMovingToParent
    }
}
