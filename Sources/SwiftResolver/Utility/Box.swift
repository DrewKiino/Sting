
import Foundation

internal protocol BoxProtocol {
  var valueType: String { get }
  var argsType: [String] { get }
  var scope: SwiftResolver.Scope { get }
}

internal class Box<T, A, B, C, D>: BoxProtocol {
  internal enum Closure {
    case noargs(BoxClosureNoArg<T>)
    case arg1(BoxClosure1Arg<T, A>)
    case args2(BoxClosure2Arg<T, A, B>)
    case args3(BoxClosure3Arg<T, A, B, C>)
    case args4(BoxClosure4Arg<T, A, B, C, D>)
  }
  
  internal let scope: SwiftResolver.Scope
  internal let closure: Closure
  
  internal let valueType = String(describing: T.self)
  internal let argsType = [A.self, B.self, C.self].map { String(describing: $0) }

  public init(
    scope: SwiftResolver.Scope,
    closure: Closure
  ) {
    self.scope = scope
    self.closure = closure
  }
}

internal func getBoxKey(_ any: Any) -> String {
  return String(describing: type(of: any))
}
