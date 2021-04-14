import Foundation

typealias FunctionID = UUID

public struct FunctionStub<Arguments, Result> {
    public init(_ function: @escaping (Arguments) throws -> Result) {
        self.id = FunctionID()
        self.function = function
    }
    
    let id: FunctionID
    let function: (Arguments) throws -> Result
}
