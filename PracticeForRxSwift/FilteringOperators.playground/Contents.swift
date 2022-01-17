import RxSwift

let disposeBag = DisposeBag()

print("---------ignoreElements--------")
let 취침모드 = PublishSubject<String>()

취침모드
    .ignoreElements()
    .subscribe { _ in
        print("해")
    }
    .disposed(by: disposeBag)

취침모드.onNext("스피커")
취침모드.onNext("스피커")
취침모드.onNext("스피커")

//next event 무시하는게 ignoreElement

취침모드.onCompleted()

print("---------elementAt--------")
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("스피커")
두번울면깨는사람.onNext("스피커")
두번울면깨는사람.onNext("피노키오")
두번울면깨는사람.onNext("스피커")

print("---------filter--------")
Observable.of(1,2,3,4,5,6,7,8)
    .filter {
        $0 % 2 == 0
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------skip--------")
Observable.of(1,2,3,4,5,6)
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------skipWhile--------")
Observable.of(1,2,3,4,5,6,7,8)
    .skip(while: {
        $0 != 6
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------skipWhile--------")
let 손니 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손니
    .skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손니.onNext("손님1")
손니.onNext("손님2")

문여는시간.onNext("땡!")

손니.onNext("손님3")

print("---------take--------")
Observable.of(1,2,3,4,5,6)
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------takeWhile--------")
Observable.of(1,2,3,4,5,6)
    .take(while: {
        $0 != 3
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------enumerated--------")
Observable.of(1,2,3,4,5,6)
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------takeUntil--------")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("학생1")
수강신청.onNext("학생2")

신청마감.onNext("끝!")
수강신청.onNext("학생3")

print("---------distintUntilChanged--------")
Observable.of("저는" ,"저는" ,"앵무새" ,"앵무새" ,"앵무새" ,"앵무새" ,"입니다" ,"입니다", "입니다", "입니다", "저는", "앵무새", "일까요?", "일까요?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

