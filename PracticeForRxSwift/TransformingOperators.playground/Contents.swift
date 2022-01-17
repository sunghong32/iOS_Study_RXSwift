import RxSwift

let disposBag = DisposeBag()

print("---------toArray--------")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposBag)

print("---------map--------")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposBag)

print("---------flatMap--------")
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let kor = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let usa = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let olimpic = PublishSubject<선수>()

olimpic
    .flatMap { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposBag)

olimpic.onNext(kor)
kor.점수.onNext(10)

olimpic.onNext(usa)
kor.점수.onNext(10)
usa.점수.onNext(9)

print("---------flatMapLatest--------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let 제주 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposBag)

전국체전.onNext(서울)
서울.점수.onNext(9)

전국체전.onNext(제주)
서울.점수.onNext(10)
제주.점수.onNext(8)

print("---------materialize and dematerialize--------")
enum foul: Error {
case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
let 박치타  = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

let 달리100M = BehaviorSubject<선수>(value: 김토끼)

달리100M
    .flatMap { 선수 in
        선수.점수
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposBag)

김토끼.점수.onNext(1)
김토끼.점수.onError(foul.부정출발)
김토끼.점수.onNext(2)

달리100M.onNext(박치타)

print("---------전화번호 11자리--------")
let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 })
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)"}
    }
    .map {
        numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(
        onNext: {
            print($0) 
        })
    .disposed(by: disposBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(2)
input.onNext(9)
input.onNext(nil)
input.onNext(1)
input.onNext(6)
input.onNext(9)
input.onNext(9)
input.onNext(9)
input.onNext(0)
