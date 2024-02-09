//
//  TaskModel.swift
//  TodoApp
//
//  Created by Бектур Дуйшембеков on 2/7/24.
//

import Foundation

struct TaskModel: Codable {
    var title: String
    var description: String
    var isDone: Bool
}
