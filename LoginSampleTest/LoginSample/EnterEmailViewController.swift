//
//  EnterEmailViewController.swift
//  LoginSample
//
//  Created by 윤수호 on 2022/12/31.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    let mystoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpButton.layer.cornerRadius = 30
        nextButton.layer.cornerRadius = 30
       
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
        
        
    }
    @IBAction func SignUpButtonTapped(_ sender: Any){
        let SignUpViewController = self.mystoryboard.instantiateViewController(withIdentifier: "SignUpViewController")
        self.show(SignUpViewController, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }

    
    @IBAction func nextButtonTapped(_ sender:UIButton){
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] authResult, error in guard let self = self else { return }
            
            if let error = error {
                let code =  (error as NSError).code
                switch code {
                case 17007://이미 가입한 계정일 떄
                    self.loginUser(withEmail: email, password: password)
                    //로그인하기
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                
                self.showMainViewController()
            }
        }
            
    }
    
    private func showMainViewController() {
        let mainViewController = mystoryboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}
extension EnterEmailViewController:
    UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
