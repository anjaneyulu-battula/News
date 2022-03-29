//
//  LoginViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 29/03/22.
//

enum LoginScreenTags: Int {
    case email = 1000
    case password = 1001
}

enum LoginError: Error {
    case validation(description: String)

    var msg: String {
        switch self {
        case .validation(let description):
            return description
        }
    }
}


import Foundation

class LoginViewModel {

    init() {}

    func validateForm(email: String, password: String, completion: (Result<Void, LoginError>) -> Void) {

        guard !email.isEmpty && !password.isEmpty else {
            completion(.failure(.validation(description: "Email or Password is empty")))
            return
        }

        guard email.isValidEmail else {
            completion(.failure(.validation(description: "Please enter valid email")))
            return
        }

        DBManager.shared.getUserWith(email: email) { result in
            switch result {
            case .success(let user):

                guard let userDB = user else {
                    inserUser(email: email, password: password, completion: completion)
                    return
                }

                guard userDB.password == password else {
                    completion(.failure(.validation(description: "Please enter correct password")))
                    return
                }

                completion(.success(()))

            case .failure(let errorDetails):
                completion(.failure(.validation(description: errorDetails.msg)))
            }
        }

//        completion(.success(()))
    }

    func inserUser(email: String, password: String, completion: (Result<Void, LoginError>) -> Void) {
        DBManager.shared.insertUser(email: email, password: password) { result in
            switch result {
            case .success(()):
                completion(.success(()))
            case .failure(let errorDetails):
                completion(.failure(.validation(description: errorDetails.msg)))
            }
        }
    }

}

