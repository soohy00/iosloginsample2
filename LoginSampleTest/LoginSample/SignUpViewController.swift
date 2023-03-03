//
//  SignUpViewController.swift
//  LoginSample
//
//  Created by 윤수호 on 2023/01/03.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController : UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var phoneNumberCheckTextField: UITextField!
    @IBOutlet weak var emailCheckLabel: UILabel!
    @IBOutlet weak var phoneNumberCheckLabel: UILabel!
    
    let db = Firestore.firestore()
    
    @IBAction func signUpButtonTapped(_ sender:UIButton) {
        let nickname = idTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let birthDay = dateOfBirthPicker.date
        
        self.signUpUser(withEmail: email, password: password)
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        db.collection("User").addDocument(data: [:]) { [self]
            err in if let err = err {
                print(err)
            } else {
                self.db.collection("User").document("\(email)").setData(["Nickname":"\(nickname)", "E-mail":"\(email)", "PassWord":"\(password)", "PhoneNumber":"\(phoneNumber)", "BirthDay":"\(birthDay)", "UID":"\(uid)"])
                print("Success")}
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailButton, phoneButton].forEach{
            $0?.layer.borderWidth = 0.2
            $0?.layer.borderColor = UIColor.black.cgColor
            $0?.layer.cornerRadius = 10
        }
        signUpButton.layer.cornerRadius = 30
        signUpButton.layer.borderColor = UIColor.black.cgColor
        
        idTextField.becomeFirstResponder()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
//    @IBAction func emailButtonTapped(_sender: UIButton){
//        let email = emailTextField.text ?? ""
//
//        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: <#T##ActionCodeSettings#>)
//    }
    
    private func signUpUser(withEmail email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in guard let self = self else { return }
            
            if let error = error {
                let code =  (error as NSError).code
                switch code {
                case 17007://이미 가입한 계정일 떄
                    self.errorMessageLabel.text = "이미 가입된 계정입니다."
                    return
                    //로그인하기
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                    return
                }
            } else {
                
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
}
    extension SignUpViewController:
        UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
            return false
        }
    }

