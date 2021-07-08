//
//  LoginViewController.swift
//  loginValidationPractice
//
//  Created by 서혁규 on 2021/07/07.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    private lazy var idTextField:MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "id"
        tf.placeholder = "Enter your id"
        tf.leadingAssistiveLabel.text = "This is where enter your id"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.sizeToFit()
        return tf
    }()
    
    private lazy var pwTextField:MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "password"
        tf.placeholder = "Enter your password"
        tf.leadingAssistiveLabel.text = "This is where enter your password"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.sizeToFit()
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private lazy var loginButton:MDCButton = {
      let bt = MDCButton()
        bt.setTitle("login", for: UIControl.State.normal)
        bt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bt.setBackgroundColor(UIColor.purple)
        bt.isUserInteractionEnabled = false
        bt.alpha = 0.3
        
        return bt
    }()
    
    private lazy var stack:UIStackView = {
       let stack = UIStackView(arrangedSubviews: [idTextField, pwTextField, loginButton])
    
        stack.axis =  .vertical
        stack.spacing = 50
        
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        configureUI()
        configureKeyboard()
        loginBind()
    
    }
    func configureKeyboard() {
        dismissKeyboardWhenTappedAround()
        moveViewWhenKeyboardAppearedOrDisappeared()
    }
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func loginBind(){
        self.idTextField.rx.text.map{$0 ?? ""}.bind(to: viewModel.idPublishSubject).disposed(by: disposeBag)
        
        self.pwTextField.rx.text.map{$0 ?? ""}.bind(to: viewModel.pwPublishSubject).disposed(by: disposeBag)
        
        viewModel.isValid().subscribe(onNext: {valid in
            self.loginButton.isUserInteractionEnabled = valid
            if valid{
                self.loginButton.alpha = 1
            }else{
                self.loginButton.alpha = 0.3
            }
        }).disposed(by: disposeBag)
    }
    

}
