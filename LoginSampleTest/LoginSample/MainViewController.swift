//
//  MainViewController.swift
//  LoginSample
//
//  Created by 윤수호 on 2023/01/01.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MainViewController: UIViewController{
    @IBOutlet weak var welcomeLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let id = Auth.auth().currentUser?.email ?? "고객님"
        
        welcomeLabel.text = """
        환영합니다.
        \(id)님
        """
    }
    
    @IBAction func logoutButtonTapped(_ sender:UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
