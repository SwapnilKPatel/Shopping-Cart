//
//  Foundation+Extension.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation

/// Customize
@discardableResult
func customize<T>(_ value: T, _ block: (_ object: T) ->() ) -> T {
    block(value)
    return value
}

/// Execute if app is running in debugmode
/// - Parameter block: Execution Block
func executeInDebugMode(_ block: () -> ()) {
    #if DEBUG
    block()
    #endif
}

/// Print log to console
///
/// - Parameters:
///   - items: Any
///   - separator: Line Seperator
///   - terminator: Line Terminator
func consoleLog(_ item: @autoclosure () -> Any) {
    executeInDebugMode { debugPrint(item()) }
}
