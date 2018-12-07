import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

var str1 = "Hollo World"
let publishSubject = PublishSubject<String>()

publishSubject
    .subscribe {
        print("Subscription: \($0)")
    }
    .disposed(by: disposeBag)

publishSubject.onNext("GoogMorning America")
