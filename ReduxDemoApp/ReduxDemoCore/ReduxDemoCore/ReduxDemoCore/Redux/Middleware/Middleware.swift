import ReSwift

public struct MiddlewareContext<State> {
    public let dispatch: DispatchFunction
    public let getState: () -> State?
    public let next: DispatchFunction
}

public typealias FlattenedMiddleware<State> = (MiddlewareContext<State>, Action) -> Void

public func createMiddleware<State>(_ middleware: @escaping FlattenedMiddleware<State>) -> Middleware<State> {
    return { dispatch, getState in
        return { next in
            return { action in
                let context = MiddlewareContext(dispatch: dispatch, getState: getState, next: next)
                middleware(context, action)
            }
        }
    }
}
