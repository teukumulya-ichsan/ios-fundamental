import UIKit
import SystemConfiguration

// initialize the reachability
let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")

var flags = SCNetworkReachabilityFlags()
SCNetworkReachabilityGetFlags(reachability!, &flags)

if !isNetworkReachable(with: flags) {
    print("Device doesn't have internet connection")
} else {
    print("Host www.google.com is reachable")
}

#if os(iOS)
if flags.contains(.isWWAN) {
    print("Device is using mobile data")
}
#endif

// func to check if network is reachable
func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
    
    // address can access with exist config network
    let isReachable = flags.contains(.reachable)
    let needConnection = flags.contains(.connectionRequired)
    
    // address can access but must connect first
    let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionAutomatic)
    let canConnectionWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
    
    return isReachable && (!needConnection || canConnectionWithoutUserInteraction)
}
