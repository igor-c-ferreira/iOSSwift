// Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"
let text = UITextField(frame: CGRect(x:0,y:0,width:100,height:30))
text.text = str
XCPCaptureValue(str, text)