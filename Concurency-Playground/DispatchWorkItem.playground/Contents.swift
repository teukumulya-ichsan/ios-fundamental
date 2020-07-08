import UIKit

var value = 5
let workItem = DispatchWorkItem{
    value += 5
}

// this func will execute func on workItem as async
//workItem.perform()

let queue = DispatchQueue(label: "com.dicoding.dispatchWorkItem", qos: .utility)
queue.async(execute: workItem)

// notify to main thread
workItem.notify(queue: DispatchQueue.main){
    print("final value: \(value)")
}
