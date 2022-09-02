import ReSwift

public func createStore(middleware: [Middleware<AppState>] = []) -> Store<AppState> {
    Store(reducer: AppState.reduce, state: nil, middleware: middleware)
}

public enum Actions {}

enum InternalActions {}
