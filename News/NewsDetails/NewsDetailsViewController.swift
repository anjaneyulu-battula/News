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
    weak var delegate: NewsListViewControllerDelegate?

    @IBOutlet weak var newsDetailsWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsDetailsWebView.navigationDelegate = self
        registerNewsDetailsUpdate()
        viewModel.updateDetails()
    }

    private func registerNewsDetailsUpdate() {
        viewModel.newsDetailsUpdate = { [weak self] status in
            guard let weakSelf = self else { return }
            switch status {
            case .success:
                weakSelf.delegate?.markArticleAsRead()
                Utility.shared.showLoader(viewController: weakSelf)
                weakSelf.loadWebView()
            case .failure(let msg):
                Utility.shared.showAlert(viewController: weakSelf, msg: msg)
            }
        }
    }

    func loadWebView() {
        guard let urlRequest = viewModel.urlRequest else {
            Utility.shared.showAlert(viewController: self, msg: "News article URL is not available or URL parsing error")
            return
        }
        newsDetailsWebView.load(urlRequest)
    }
}

extension NewsDetailsViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Utility.shared.hideLoader(viewController: self)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let e = error as NSError
        Utility.shared.showAlert(viewController: self, msg: "\(e.domain) - \(e.localizedDescription) (\(e.code))")
        Utility.shared.hideLoader(viewController: self)
    }
}
