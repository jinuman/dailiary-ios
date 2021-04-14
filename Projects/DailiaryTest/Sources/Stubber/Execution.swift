public struct Execution<Arguments, Result>: AnyExecution {
    let arguments: Arguments
    let result: Result
}

protocol AnyExecution {}
