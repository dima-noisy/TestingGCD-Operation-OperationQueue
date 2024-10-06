import UIKit

let queue = DispatchQueue(label: "myFirstQueue", qos: .default)

queue.async {
    print("hi!")
}

let concurrency = DispatchQueue(
    label: "concurrency",
    qos: .userInteractive,
    attributes: .concurrent,
    autoreleaseFrequency: .workItem
)

let serial = DispatchQueue(label: "serial")

private func showCurrencySync() {
    concurrency.sync {
        print(1)
    }
    concurrency.sync {
        print(2)
    }
    concurrency.sync {
        print(3)
    }
    concurrency.sync {
        print(4)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        print(55)
    }
}

private func showCurrencyAsync() {
    concurrency.async {
        print(1)
    }
    concurrency.async {
        print(2)
    }
    concurrency.async {
        print(3)
    }
    concurrency.async {
        print(4)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        print(55)
    }
}

private func showSerialSync() {
    serial.sync {
        print(1)
    }
    serial.sync {
        print(2)
    }
    serial.sync {
        print(3)
    }
    serial.sync {
        print(4)
    }
}

private func showSerialAsync() {
    serial.async {
        print(1)
    }
    serial.async {
        print(2)
    }
    serial.async {
        print(3)
    }
    serial.async {
        print(4)
    }
}

private func showDispatchQoS() {
    DispatchQueue.global().async {
        print("global")
    }
    DispatchQueue.global(qos: .background).async {
        print("background")
    }
    DispatchQueue.global(qos: .userInteractive).async {
        print("userInteractive")
    }
    DispatchQueue.global(qos: .userInitiated).async {
        print("userInitiated")
    }
    DispatchQueue.global(qos: .utility).async {
        print("utility")
    }
    DispatchQueue.global(qos: .default).async {
        print("default")
    }
}

let workItem = DispatchWorkItem(block: {
    print("hi again!")
})

private func makeDispatchGroup() {
        let group = DispatchGroup()
        var fullText = "hh"
        var name = ""
        var age = ""
        
        DispatchQueue.global().async {
            group.enter()
            sleep(2)
            name = "Artem"
            group.leave()
            
            group.enter()
            sleep(2)
            age = " 18"
            group.leave()
            
            fullText = name + age
            
            group.notify(queue: .main) {
                print(fullText)
            }
        }
    }

//showCurrencySync()
//showCurrencyAsync()
//showSerialSync()
//showSerialAsync()
//showDispatchQoS()

makeDispatchGroup()

queue.async(execute: workItem)

let queue2 = OperationQueue()
queue2.addOperation {
    print("hello!")
}

let op3 = Operation()
op3.name = "Operation3"

OperationQueue.main.addOperations([op3], waitUntilFinished: false)
let operations = OperationQueue.main.operations

operations.map {
    op in
    if op.name == "Operation3" {
        op.cancel()
        print("finished")
    }
}
