import UIKit

class ThreadSafeArray {
    let isolation = DispatchQueue(label: "com.dicoding.dispatchbarrier", attributes: .concurrent)
    
    private var _array: [Int] = []
    
    var array: [Int] {
        get {
            return isolation.sync {
                _array
            }
        }
        set {
            isolation.async(flags: .barrier) {
                self._array = newValue
            }
        }
    }
}
