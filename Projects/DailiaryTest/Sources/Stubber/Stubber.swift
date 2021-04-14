import Foundation

// MARK: - Store

private typealias Function = Any // f: @escaping (A) throws -> R

private final class StubStore {
    var fuctions: [FunctionID: Function] = [:]
    var executions: [FunctionID: [AnyExecution]] = [:]
}

private let stubStore = StubStore()
private let lock = NSLock()


// MARK: - Stubber

public final class Stubber {
    public static func register<A, R>(
        _ functionStub: FunctionStub<A, R>,
        with closure: @escaping (A) -> R
    ) {
        lock.lock()
        stubStore.fuctions[functionStub.id] = closure
        stubStore.executions[functionStub.id]?.removeAll()
        lock.unlock()
    }
    
    public static func invoke<A, R>(
        _ functionStub: FunctionStub<A, R>,
        args: A,
        default: @autoclosure () -> R
    ) -> R {
        let closure = stubStore.fuctions[functionStub.id] as? (A) -> R
        let result = closure?(args) ?? `default`()
        
        lock.lock()
        let execution = Execution<A, R>(arguments: args, result: result)
        stubStore.executions[functionStub.id] = (stubStore.executions[functionStub.id] ?? []) + [execution]
        lock.unlock()
        
        return result
    }
    
    public static func executions<A, R>(_ functionStub: FunctionStub<A, R>) -> [Execution<A, R>] {
        return stubStore.executions[functionStub.id] as? [Execution<A, R>] ?? []
    }
    
    public static func clearExecutions<A, R>(_ functionStub: FunctionStub<A, R>) {
        lock.lock()
        stubStore.executions[functionStub.id]?.removeAll()
        lock.unlock()
    }
}
