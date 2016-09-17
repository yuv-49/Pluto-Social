//
//  ViewController.swift
//  Pluto-Social
//
//  Created by yuvraj singh on 17/09/16.
//  Copyright © 2016 Pluto Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: fancyField!
    @IBOutlet weak var passwordField: fancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //Segue should not be performed in view did load.
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.stringForKey(KEY_UID){
            print("YS: id found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
            
        }

    }

  
    
    @IBAction func facebookButtonPressed(_ sender: AnyObject) {
        
       let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self){
            (result, error) in
            if error != nil{
                print("YS: unable to authenticate with facebook - \(error)")
                
            }else if result?.isCancelled == true {
                print("YS: user cancelled fb authentication)")

            }else{
                 print("YS: successfully authenticated with fb")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.FirebaseAuth(credential)
            }
        }
        
    }
    
    // own created code.
    func FirebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
            if error != nil{
            print("YS:unable to authenticate with firebase - \(error)" )
            }else {
                  print("YS:successfully authenticate with firebase " )
                if let user = user{
                   self.completeSignIn(id: user.uid)
                }
            }
            })
    }

    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text , let pwd = passwordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("YS: Email user authenticated with firebase")
                    if let user = user{
                         self.completeSignIn(id: (user.uid))
                    }
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("YS: unable to authenticate with firebase using email")
                        }else{
                            print("YS: Successfully authenticated with firebase using email")
                            if let user = user{
                                self.completeSignIn(id: (user.uid))
                            }
                        }
                    })
                }
            
        })
        }
        
    }
    func completeSignIn(id: String){
       let keychainResult =  KeychainWrapper.setString(id, forKey: KEY_UID)
        print("YS: data saved to keychain")
        performSegue(withIdentifier: "goToFeed", sender: nil)

        
    }
}

