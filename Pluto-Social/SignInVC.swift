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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
            })
    }

}

