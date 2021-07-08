//
//  LoginViewModel.swift
//  loginValidationPractice
//
//  Created by 서혁규 on 2021/07/08.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    let idPublishSubject = PublishSubject<String>()
    let pwPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        Observable.combineLatest(idPublishSubject.asObserver(), pwPublishSubject.asObserver()).map {
            id, pw in
            return id.count > 3 && pw.count > 3
        }
    }
}
