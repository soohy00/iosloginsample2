//
//  LoginViewController.swift
//  LoginSample
//
//  Created by 윤수호 on 2022/12/31.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach{
            $0?.layer.borderWidth = 0.5
            $0?.layer.borderColor = UIColor.black.cgColor
            $0?.layer.cornerRadius = 30
        }
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
}
