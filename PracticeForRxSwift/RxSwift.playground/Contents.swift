import UIKit
import Foundation
import RxSwift
import RxCocoa
import Dispatch
//
//public func example(of description: String, action: () -> Void) {
//    print("\n--- Example of:", description, "---")
//    action()
//}
//
//example(of: "just, of, from") {
//    // 1
//    let one = 1
//    let two = 2
//    let three = 3
//
//    //2
//    let observable:Observable<Int> = Observable<Int>.just(one)
//    let observable2 = Observable.of(one, two, three)
//    let observable3 = Observable.of([one, two, three])
//    example(of: "subscribe") {
//        let one = 1
//        let two = 2
//        let three = 3
//
//        let observable = Observable.of(one, two, three)
//        observable.subscribe({ (event) in
//            print(event)
//        })
//
//        /* Prints:
//         next(1)
//         next(2)
//         next(3)
//         completed
//        */
//
//        observable.subscribe { event in
//            if let element = event.element {
//                print(element)
//            }
//        }
//
//        /* Prints:
//         1
//         2
//         3
//        */
//
//        observable.subscribe(onNext: { (element) in
//            print(element)
//        })
//
//        /* Prints:
//         1
//         2
//         3
//        */
//
//        example(of: "empty") {
//            let observable = Observable<Void>.empty()
//
//            observable.subscribe(
//
//                // 1
//                onNext: { (element) in
//                    print(element)
//            },
//
//                // 2
//                onCompleted: {
//                    print("Completed")
//            }
//            )
//        }
//
//        /* Prints:
//         Completed
//        */
//
//        example(of: "never") {
//            let observable = Observable<Any>.never()
//
//            observable
//                .subscribe(
//                    onNext: { (element) in
//                        print(element)
//                },
//                    onCompleted: {
//                        print("Completed")
//                }
//            )
//        }
//
//        example(of: "dispose") {
//
//            // 1
//            let observable = Observable.of("A", "B", "C")
//
//            // 2
//            let subscription = observable.subscribe({ (event) in
//
//                // 3
//
//                print(event)
//            })
//
//            subscription.dispose()
//        }
//
//        example(of: "create") {
//            let disposeBag = DisposeBag()
//
//            Observable<String>.create({ (observer) -> Disposable in
//                // 1
//                observer.onNext("1")
//
//                // 2
//                observer.onCompleted()
//
//                // 3
//                observer.onNext("?")
//
//                // 4
//                return Disposables.create()
//            })
//        }
//
//        example(of: "create") {
//            let disposeBag = DisposeBag()
//
//            Observable<String>.create({ (observer) -> Disposable in
//                // 1
//                observer.onNext("1")
//
//                // 2
//                observer.onCompleted()
//
//                // 3
//                observer.onNext("?")
//
//                // 4
//                return Disposables.create()
//            })
//        }
//
//        example(of: "create") {
//            let disposeBag = DisposeBag()
//
//            Observable<String>.create({ (observer) -> Disposable in
//                // 1
//                observer.onNext("1")
//
//                // 2
//                observer.onCompleted()
//
//                // 3
//                observer.onNext("?")
//
//                // 4
//                return Disposables.create()
//            })
//                .subscribe(
//                    onNext: { print($0) },
//                    onError: { print($0) },
//                    onCompleted: { print("Completed") },
//                    onDisposed: { print("Disposed") }
//            ).disposed(by: disposeBag)
//        }
//
//        /* Prints:
//         1
//         Completed
//         Disposed
//        */
//
//        enum MyError: Error {
//            case anError
//        }
//
//        example(of: "create") {
//            let disposeBag = DisposeBag()
//
//            Observable<String>.create({ (observer) -> Disposable in
//                // 1
//                observer.onNext("1")
//
//                // 5
//                observer.onError(MyError.anError)
//
//                // 2
//                observer.onCompleted()
//
//                // 3
//                observer.onNext("?")
//
//                // 4
//                return Disposables.create()
//            })
//                .subscribe(
//                    onNext: { print($0) },
//                    onError: { print($0) },
//                    onCompleted: { print("Completed") },
//                    onDisposed: { print("Disposed") }
//            ).disposed(by: disposeBag)
//        }
//
//        /* Prints:
//         1
//         anError
//         Disposed
//        */
//
//        example(of: "deferred") {
//            let disposeBag = DisposeBag()
//
//            // 1
//            var flip = false
//
//            // 2
//            let factory: Observable<Int> = Observable.deferred{
//
//                // 3
//                flip = !flip
//
//                // 4
//                if flip {
//                    return Observable.of(1,2,3)
//                } else {
//                    return Observable.of(4,5,6)
//                }
//            }
//
//            for _ in 0...3 {
//                factory.subscribe(onNext: {
//                    print($0, terminator: "")
//                })
//                    .disposed(by: disposeBag)
//
//                print()
//            }
//        }
//        /* Prints:
//        123
//        456
//        123
//        456
//        */
//
//        example(of: "Single") {
//
//            // 1
//            let disposeBag = DisposeBag()
//
//            // 2
//            enum FileReadError: Error {
//                case fileNotFound, unreadable, encodingFailed
//            }
//
//            // 3
//            func loadText(from name: String) -> Single<String> {
//                // 4
//                return Single.create{ single in
//                    // 4 - 1
//                    let disposable = Disposables.create()
//
//                    // 4 - 2
//                    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
//                        single(.failure(FileReadError.fileNotFound))
//                        return disposable
//                    }
//
//                    // 4 - 3
//                    guard let data = FileManager.default.contents(atPath: path) else {
//                        single(.failure(FileReadError.unreadable))
//                        return disposable
//                    }
//
//                    // 4 - 4
//                    guard let contents = String(data: data, encoding: .utf8) else {
//                        single(.failure(FileReadError.encodingFailed))
//                        return disposable
//                    }
//
//                    // 4 - 5
//                    single(.success(contents))
//                    return disposable
//                }
//            }
//
//            loadText(from: "Copyright")
//                   .subscribe{
//                       switch $0 {
//                       case .success(let string):
//                           print(string)
//                       case .failure(let error):
//                           print(error)
//                       }
//                   }
//                   .disposed(by: disposeBag)
//        }
//
//        example(of: "never") {
//            let observable = Observable<Any>.of(1,2,3)
//
//            // 1. 문제에서 요구한 dispose bag 생성
//            let disposeBag = DisposeBag()
//
//            // 2. 그냥 뚫고 지나간다는 do의 onSubscribe 에다가 구독했음을 표시하는 문구를 프린트하도록 함
//            observable.do(
//                onSubscribe: {print("Subscribed")},
//                onSubscribed: {
//                    print("했지롱")
//                },
//                onDispose: {
//                    print("Disposed")
//                }
//            ).subscribe(                    // 3. 그리고 subscribe 함
//                onNext: { (element) in
//                    print(element)
//                },
//                onCompleted: {
//                    print("Completed")
//                }
//            )
//            .disposed(by: disposeBag)            // 4. 앞서 만든 쓰레기봉지에 버려줌
//        }
//
//        example(of: "never") {
//            let observable = Observable<Any>.never()
//            let disposeBag = DisposeBag()            // 1. 역시 dispose bag 생성
//
//            observable
//                .debug("never 확인")            // 2. 디버그 하고
//                .subscribe()                    // 3. 구독 하고
//                .disposed(by: disposeBag)     // 4. 쓰레기봉지에 쏙
//        }
//
//        /* Prints:
//        2018-01-09 18:00:24.752: never 확인 -> subscribed
//        2018-01-09 18:00:24.754: never 확인 -> isDisposed
//        */
//
//        example(of: "PublishSubject") {
//
//            // 1
//            let subject = PublishSubject<String>()
//
//            // 2
//            subject.onNext("Is anyone listening?")
//
//            // 3
//            let subscriptionOne = subject
//                .subscribe(onNext: { (string) in
//                    print(string)
//                })
//
//            // 4
//            subject.on(.next("1"))        //Print: 1
//
//            // 5
//            subject.onNext("2")        //Print: 2
//
//            example(of: "PublishSubject") {
//                let subject = PublishSubject<String>()
//                subject.onNext("Is anyone listening?")
//
//                let subscriptionOne = subject
//                    .subscribe(onNext: { (string) in
//                        print(string)
//                    })
//                subject.on(.next("1"))
//                subject.onNext("2")
//
//                // 1
//                let subscriptionTwo = subject
//                    .subscribe({ (event) in
//                        print("2)", event.element ?? event)
//                    })
//
//                // 2
//                subject.onNext("3")
//
//                // 3
//                subscriptionOne.dispose()
//                subject.onNext("4")
//
//                // 4
//               // subject.onCompleted()
//
//                // 5
//                subject.onNext("5")
//
//                // 6
//                subscriptionTwo.dispose()
//
//                let disposeBag = DisposeBag()
//
//                // 7
//                subject
//                    .subscribe {
//                        print("3)", $0.element ?? $0)
//                }
//                    .disposed(by: disposeBag)
//
//                subject.onNext("?")
//            }
//        }
//
//
//    }
//}
//
////3
//example(of: "BehaviorSubject") {
//    // 1
//     enum MyError: Error {
//         case anError
//     }
//
//    // 4
//    let subject = BehaviorSubject(value: "Initial value")
//    let disposeBag = DisposeBag()
//
//    // 6
//    //subject.onNext("X")
//
//    // 5
//    subject
//        .subscribe{
//            print(label: "1)", event: $0)
//        }
//        .disposed(by: disposeBag)
//
//    // 7
//    subject.onError(MyError.anError)
//
//    // 8
//    subject
//        .subscribe {
//            print(label: "2)", event: $0)
//        }
//        .disposed(by: disposeBag)
//}
//
//// 2
//func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
//    print(label, event.element ?? event.error ?? event as Any)
//}
//
//example(of: "ReplaySubject") {
//
//    enum MyError: Error {
//        case anError
//    }
//
//    // 1
//    let subject = ReplaySubject<String>.create(bufferSize: 2)
//    let disposeBag = DisposeBag()
//
//    // 2
//    subject.onNext("1")
//    subject.onNext("2")
//    subject.onNext("3")
//
//    // 3
//    subject
//        .subscribe {
//            print(label: "1)", event: $0)
//        }
//        .disposed(by: disposeBag)
//
//    subject
//        .subscribe {
//            print(label: "2)", event: $0)
//        }
//        .disposed(by: disposeBag)
//
//    subject.onNext("4")
//
//    subject.subscribe {
//        print(label: "3)", event: $0)
//    }
//    .disposed(by: disposeBag)
//
//    subject.onError(MyError.anError)
//
//      /* Prints:
//     1) 4
//     2) 4
//     1) anError
//     2) anError
//     3) 3
//     3) 4
//     3) anError
//     */
//
//    subject.dispose()
//
//    /* Prints:
//     3) Object `RxSwift.(ReplayMany in _33052C2CE59F358A8740AFDD4371DD39)<Swift.String>` was already disposed.
//     */
//}
//
//enum PhotoError: Error {
//    case anError
//}
//
//class PhotoClass {
//    var images: [UIImage] = []
//    static let typeProperty = "sunghong" // 공용 프로퍼티
//    var storedPropery = "joseph" // 인스턴스 각각에 대한 프로퍼티
//
//    static func save() { // 공용 메서드
//        print("saved!")
//    }
//    func save1() { // 인스턴스 각각에 대한 메서드
//
//    }
//}
//
//var disposebag = DisposeBag()
//
//let photoInstance: PhotoClass? = PhotoClass()
//var selectedPhotos = PublishSubject<UIImage>()
//
//selectedPhotos
//    .subscribe(onNext: { newImage in
//        guard var images = photoInstance?.images else { return }
//        images.append(newImage)
//    }, onError: { error in
//        print("\(error)")
//    }, onDisposed: {
//        print("completed photo selection")
//    })
//    .disposed(by: disposebag)
//
//selectedPhotos.onError(PhotoError.anError)
////selectedPhotos.onCompleted()
//
//Observable<String>.create { observable in
//    observable.onNext("vlvk")
//    observable.onCompleted()
//    return Disposables.create()
//}
//.subscribe { str in
//    print(str)
//} onDisposed: {
//    print("heejung")
//}
//
//
//
//Single<String>.create { single in
//    let toggle: Bool = true
//    if toggle {
//        single(.success("성공"))
//        // onNext + onCompleted
//    } else {
//        single(.failure(PhotoError.anError)) // event
//    }
//
//    return Disposables.create()
//}
//
//.subscribe { str in
//    print(str)
//} onFailure: { error in
//    print(error)
//} onDisposed: {
//    print("Disposed")
//}
//
//example(of: "ignoreElements") {
//
//    // 1
//    let strikes = PublishSubject<String>()
//    let disposeBag = DisposeBag()
//
//    // 2
//    strikes
//        .ignoreElements()
//        .subscribe({ _ in
//            print("You're out!")
//        })
//        .disposed(by: disposeBag)
//
//    // 3
//    strikes.onNext("X")
//    strikes.onNext("X")
//    strikes.onNext("X")
//
//    // 4
//    strikes.onCompleted()
//}
//
//example(of: "elementAt") {
//
//    // 1
//    let strikes = PublishSubject<String>()
//    let disposeBag = DisposeBag()
//
//    // 2
//    strikes
//        .element(at: 2)
//        .subscribe(onNext: { $0
//            print("You're out!")
//            print($0)
//        })
//        .disposed(by: disposeBag)
//
//    // 3
//    strikes.onNext("1X")
//    strikes.onNext("2X")
//    strikes.onNext("3X")
//}
//
//example(of: "takeWhile") {
//    let disposeBag = DisposeBag()
//
//    // 1
//    Observable.of(2,2,4,4,6,6)
//        // 2
//        .enumerated()
//        // 3
//        .take(while: { index, value in
//            // 4
//            value % 2 == 0 && index < 3
//        })
//        // 5
//        .map { $0.element }
//        // 6
//        .subscribe(onNext: {
//            print($0)
//        })
//        .disposed(by: disposeBag)
//}
//
//example(of: "toArray") {
//    let disposeBag = DisposeBag()
//
//    // 1
//    Observable.from(["A", "B", "C"])
//        // 2
//       // .toArray()
//        .subscribe(onNext: {
//            print($0)
//        })
//        .disposed(by: disposeBag)
//
//    /* Prints:
//        ["A", "B", "C"]
//    */
//}
//
//struct Student {
//    var score: BehaviorSubject<Int>
//}
//
//example(of: "flatMapLatest") {
//    let disposeBag = DisposeBag()
//
//    let ryan = Student(score: BehaviorSubject(value: 80))
//    let charlotte = Student(score: BehaviorSubject(value: 90))
//
//    let student = PublishSubject<Student>()
//
//    student
//        .flatMapLatest {
//            $0.score
//    }
//        .subscribe(onNext: {
//            print($0)
//        })
//        .disposed(by: disposeBag)
//
//    student.onNext(ryan)
//    ryan.score.onNext(85)
//
//    student.onNext(charlotte)
//
//    // 1
//    ryan.score.onNext(95)
//    charlotte.score.onNext(100)
//
//    /* Prints:
//        80 85 90 100
//    */
//}
//
//example(of: "materialize and dematerialize") {
//
//    // 1
//    enum MyError: Error {
//        case anError
//    }
//
//    let disposeBag = DisposeBag()
//
//    // 2
//    let ryan = Student(score: BehaviorSubject(value: 80))
//    let charlotte = Student(score: BehaviorSubject(value: 100))
//
//    let student = BehaviorSubject(value: ryan)
//
//    // 3
//    let studentScore = student
//        .flatMapLatest{
//            $0.score.materialize()
//    }
//
//    // 4
//    studentScore
//        // 1
//        .filter {
//            guard $0.error == nil else {
//               print($0.error!)
//                return false
//            }
//
//            return true
//        }
//        // 2
//        .dematerialize()
//        .subscribe(onNext: {
//            print($0)
//        })
//        .disposed(by: disposeBag)
//
//        /* Prints:
//         80
//         85
//         anError
//         100
//        */
//    // 5
//    ryan.score.onNext(85)
//    ryan.score.onError(MyError.anError)
//    ryan.score.onNext(90)
//
//    // 6
//    student.onNext(charlotte)
//
//    /* Prints:
//        80
//        85
//        Unhandled error happened: anError
//    */
//}
//
//let disposeBag = DisposeBag()
//Observable.of(1, 2, nil, 3)
//    .flatMap { $0 == nil ? Observable.empty() : Observable.just($0!) }
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//MARK: - 강의

print("-------Just------")
Observable<Int>.just(1)
    .subscribe(
        onNext: {
            print($0)
        }
    )

print("-------Of------")
Observable<Int>.of(1,2,3,4,5)
    .subscribe(
        onNext: {
            print($0)
        }
    )

print("")

Observable.of([1,2,3,4,5])
    .subscribe(
        onNext: {
            print($0)
        }
    )

print("-------From------")
Observable.from([1,2,3,4,5])
    .subscribe(
        onNext: {
            print($0)
        }
    )

print("-------Subscribe------")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }

print("-------Subscribe2------")
Observable.of(1,2,3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("-------Subscribe3------")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })

print("-------Empty------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }
// 1. 즉시 종료를 위해
// 2. 0개의 리턴값

print("-------Never------")
Observable<Void>.never()
    .debug("never")
    .subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("Completed")
    })

print("-------Range------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })

print("-------Dispose------")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("-------DisposeBag------")
let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------Create------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    //observer.on(.next(1))
    observer.onCompleted()
    //    observer.on(.completed)
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-------Create2------")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(onNext: {
    print($0)
}, onCompleted: {
    print("completed")
}, onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)

print("-------deffered------")
Observable.deferred {
    Observable.of(1,2,3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-------deffered2------")
var 뒤집기: Bool = false

let factory: Observable<Any> = Observable.deferred {
    뒤집기 = !뒤집기

    if 뒤집기 {
        return Observable.of("👍")
    } else {
        return Observable.of("❤️")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
        .disposed(by: disposeBag)
}

print("-------Single1------")
enum TraitsError: Error {
    case single
    case maybe
    case completable
}

Single<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0)")
        },
        onDisposed: {
            print("Disposed")
        }
    )
    .disposed(by: disposeBag)


print("-------Single2------")

Observable<String>.create{ observable -> Disposable in
    observable.onError(TraitsError.single)
    return Disposables.create()
}
    .asSingle()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0.localizedDescription)")
        },
        onDisposed: {
            print("Disposed")
        }
    )
    .disposed(by: disposeBag)

print("-------Single3------")

struct SomeJSON: Decodable {
    var name: String = ""
    var myName: String = ""
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
{"name":"park"}
"""

let json2 = """
{"myName":"young"}
"""

func decode(json: String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self, from: data)
        else {
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe {
        switch $0 {
            case .success(let json):
                print(json.name)
            case .failure(let error):
                print(error)
        }
    }
    .disposed(by: disposeBag)

decode(json: json2)
    .subscribe {
        switch $0 {
            case .success(let json):
                print(json.myName)
            case .failure(let error):
                print(error)
        }
    }
    .disposed(by: disposeBag)
