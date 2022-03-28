//
//  LoginViewController.swift
//  News
//
//  Created by Anjaneyulu Battula on 29/03/22.
//

import UIKit

class LoginViewController: UIViewController {

    let viewModel = LoginViewModel()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        emailTextField.tag = LoginScreenTags.email.rawValue

        passwordTextField.delegate = self
        passwordTextField.tag = LoginScreenTags.password.rawValue

    }

    @IBAction func loginButtonAction(_ sender: Any) {

        viewModel.validateForm(email: emailTextField.text ?? "",
                               password: passwordTextField.text ?? "") { result in
            switch result {
            case .success():
                viewModel.setEmailId(email: emailTextField.text ?? "")

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let newsListViewController = storyBoard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                newsListViewController.viewModel = NewsListViewModel()
                let navController = UINavigationController(rootViewController: newsListViewController)
                navController.modalPresentationStyle = .fullScreen
//                self.navigationController?.modalPresentationStyle = .overCurrentContext
                self.navigationController?.present(navController, animated: true, completion: nil)

//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let newsListViewController = storyBoard.instantiateViewController(withIdentifier: "NavNewsListViewController") as! UINavigationController
//                newsListViewController.viewModel = NewsListViewModel()
//                self.navigationController?.modalPresentationStyle = .fullScreen
//                self.navigationController?.present(newsListViewController, animated: true, completion: nil)

            case .failure(let errorDetails):
                Utility.shared.showAlert(viewController: self, msg: errorDetails.msg)
            }
        }

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

extension LoginViewController: UITextFieldDelegate {


}
