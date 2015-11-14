###USEFUL SWIFT DOCS###

https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html  

*Shell: http://stackoverflow.com/questions/26971240/how-do-i-run-an-terminal-command-in-a-swift-script-e-g-xcodebuild

```import Foundation

func shell(args: String...) -> Int32 {
    let task = NSTask()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

shell("ls")```


```let randomInt = Int(arc4random_uniform(UInt32(sentList.count)))```
