import RxSwift

let disposeBag = DisposeBag()

print("--------------startWith-------------")

let 노랑반 = Observable.of(1,2,3)

노랑반
    .enumerated()
    .map { index, element in
        return element + 5 + index
    }
    .startWith(4)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------concat1-------------")
let 노랑반어린이들 = Observable<String>.of("1","2","3")
let 선생님 = Observable<String>.of("4")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------concat2-------------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------concatMap-------------")
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("1","2","3"),
    "파랑반": Observable.of("4","5","6")
]

Observable.of("노랑반","파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })

print("--------------merge1-------------")
let 강북 = Observable.from(["강북구","성북구","동대문구","종로구"])
let 강남 = Observable.from(["강남구","강동구","영등포구","양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------merge2-------------")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------combineLatest1-------------")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")

print("--------------combineLatest2-------------")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short,.long)
let 현재날짜 = Observable.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(날짜표시형식, 현재날짜, resultSelector: { 형식, 날짜 -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = 형식
        return dateFormatter.string(from: 날짜)
    })

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------combineLatest3-------------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")

print("--------------zip-------------")
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승,.승,.패,.승,.패,.패)
let 선수 = Observable<String>.of("한국","중국","미국","일본","영국","캐나다")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------withLatestFrom1-------------")
let trigger = PublishSubject<Void>()
let player = PublishSubject<String>()

trigger
    .withLatestFrom(player)
    //.distinctUntilChanged() 중복값 제거
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

player.onNext("1")
player.onNext("12")
player.onNext("123")

trigger.onNext(Void())
trigger.onNext(Void())

print("--------------sample-------------")
let start = PublishSubject<Void>()
let f1player = PublishSubject<String>()

f1player
    .sample(start)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

f1player.onNext("1")
f1player.onNext("12")
f1player.onNext("123")

start.onNext(Void())
start.onNext(Void())
start.onNext(Void())

print("--------------amb-------------")
let bus = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let busflatform = bus.amb(bus2)

busflatform
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus2.onNext("버스2-승객0")
bus.onNext("버스-승객0")
bus.onNext("버스-승객1")
bus2.onNext("버스2-승객1")
bus.onNext("버스-승객3")
bus2.onNext("버스2-승객1")

print("--------------switchLatest-------------")
let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let handsup = PublishSubject<Observable<String>>()

let handsupPeople = handsup.switchLatest()

handsupPeople
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

handsup.onNext(student1)
student1.onNext("im 1")
student2.onNext("its me")

handsup.onNext(student2)
student2.onNext("im 2")
student1.onNext("im still")

handsup.onNext(student3)
student2.onNext("oh me")
student1.onNext("when")
student3.onNext("im 3")

handsup.onNext(student1)
student1.onNext("no wrong")
student2.onNext("sad")
student3.onNext("i think im win")
student2.onNext("this is shit?")

print("--------------reduce-------------")
Observable.from((1...10))
//    .reduce(0, accumulator: { summury, newValue in
//        return summury + newValue
//    })
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------------scan-------------")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
