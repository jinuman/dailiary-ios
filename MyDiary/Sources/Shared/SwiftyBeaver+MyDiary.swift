//
//  SwiftyBeaver+MyDiary.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 11/02/2020.
//  Copyright © 2020 jinuman. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

extension SwiftyBeaver {
    
    /**
     로그를 찍어보고 싶은 경우 이 함수를 사용하세요.
     
     - ex) log.debugPrint("Function called", .verbose)
     */
    
    class func debugPrint(
        _ message: @autoclosure () -> Any,
        _ file: String = #file,
        _ function: String = #function,
        line: Int = #line,
        context: Any? = nil,
        level: SwiftyBeaver.Level = .debug)
    {
        #if DEBUG
        switch level {
        case .verbose:
            log.verbose(message(), file, function, line: line, context: context)
        case .debug:
            log.debug(message(), file, function, line: line, context: context)
        case .info:
            log.info(message(), file, function, line: line, context: context)
        case .warning:
            log.warning(message(), file, function, line: line, context: context)
        default:
            log.error(message(), file, function, line: line, context: context)
        }
        #endif
    }
    
}
