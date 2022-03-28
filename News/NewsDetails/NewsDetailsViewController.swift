//
//  NewsDetailsViewController.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController {

    var viewModel: NewsDetailsViewModel!

    @IBOutlet weak var newsDetailsWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadWebView()
        viewModel.updateDetails()
        registerNewsDetailsUpdate()
    }

    private func registerNewsDetailsUpdate() {
        viewModel.newsDetailsUpdate = { [weak self] status in
            guard let weakSelf = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                Utility.shared.hideLoader(viewController: weakSelf)
                switch status {
                case .success:
                    break
                case .failure(let msg):
                    Utility.shared.showAlert(viewController: weakSelf, msg: msg)
                }
            }
        }
    }

    func loadWebView() {
        newsDetailsWebView.load(viewModel.urlRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
