//
//  SwiftyBeaverExtensions.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 11/02/2020.
//  Copyright © 2020 jinuman. All rights reserved.
//

import Foundation
import SwiftyBeaver

let logger = SwiftyBeaver.self

extension SwiftyBeaver {
    
    /**
     로그를 찍어보고 싶은 경우 이 함수를 사용하세요.
     
     - ex) logger.debugPrint("Function called", .verbose)
     */
    static func debugPrint(
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
            logger.verbose(message(), file, function, line: line, context: context)
        case .debug:
            logger.debug(message(), file, function, line: line, context: context)
        case .info:
            logger.info(message(), file, function, line: line, context: context)
        case .warning:
            logger.warning(message(), file, function, line: line, context: context)
        default:
            logger.error(message(), file, function, line: line, context: context)
        }
        #endif
    }
    
}
