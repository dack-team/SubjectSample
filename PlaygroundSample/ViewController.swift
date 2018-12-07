//
//  ViewController.swift
//  PlaygroundSample
//
//  Created by 石垣駿 on 2018/12/07.
//  Copyright © 2018年 石垣駿. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let publishSubject = PublishSubject<String>()
    let behaviorSubject = BehaviorSubject<String>(value: "First Hello")
    let variable = Variable<String?>(nil)
    var str1 = "Hollo World"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // publishSubject
        publishSubject
            .subscribe {
                print("Publish Subscription: \($0)")
            }
            .disposed(by: disposeBag)
        
        // BehaviorSubject
        behaviorSubject
            .subscribe {
                print("Behavior Subscription: \($0)")
            }
            .disposed(by: disposeBag)
        
        // Variable
        variable.asObservable()
            .bind { [weak self] (str) in
                guard let this = self, let str = str else {
                    print("Variable Subscription: nil")
                    return
                }
                this.str1 = str
                
                print(this.str1)
            }
            .disposed(by: disposeBag)
        
        onNext()
    }

    func onNext() {
        // publishSubjectのイベント発行
        publishSubject.onNext("GoogMorning America")
        behaviorSubject.onNext("Second Hello")
        
        variable.value = "Good Evening"
    }
}

