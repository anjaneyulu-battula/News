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
