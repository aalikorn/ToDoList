//
//  AppError.swift
//  CommonModels
//
//  Created by Даша Николаева on 24.07.2025.
//

public enum AppError: Error {
    case noTasksFound
    case unknown
    
    public func appErrorLocalizedDescription() -> String {
        switch self {
        case .noTasksFound:
            return "У вас пока нет задач, создайте новую!"
        case .unknown:
            return "Произошла ошибка"
        }
    }
}
