//
//  AlertState.swift
//  ReduxDemoCore
//
//  Created by Nikita Krupiei on 25.08.2022.
//

import ReSwift

public enum ApplicationAlerts {
    case addNewItemToList
}

extension Actions {
    public enum AlertAction: Action {
        case showAlertOfType(ApplicationAlerts)
        case alertClosed
    }
}

public struct AlertState {
    public let currentAlertToShow: ApplicationAlerts
}

extension AlertState {
    public static func reduce(action: Action, state: Self?) -> Self? {
        switch action {
        case Actions.AlertAction.showAlertOfType(let alertType):
            return Self(currentAlertToShow: alertType)
        case Actions.AlertAction.alertClosed:
            return nil
        default:
            break
        }
        
        return state
    }
}
