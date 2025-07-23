//
//  EditTaskPresenterMocks.swift
//  Scenes
//
//  Created by Даша Николаева on 23.07.2025.
//

import Foundation
import CommonModels
import Core
@testable import Scenes

final class EditTaskPresenterMock: EditTaskPresentingLogic {
    var presentFetchResponseCallback: ((EditTask.Fetch.Response) -> Void)?
    var presentBackResponseCallback: (() -> Void)?

    func present(_ response: Scenes.EditTask.Fetch.Response) {
        presentFetchResponseCallback?(response)
    }

    func present(_ response: Scenes.EditTask.Back.Response) {
        presentBackResponseCallback?()
    }
}
