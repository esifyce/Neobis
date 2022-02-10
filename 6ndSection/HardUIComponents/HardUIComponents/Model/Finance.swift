//
//  Finance.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import Foundation

struct Finance {
    var image: String
    var title: String
    var price: Int
    var category: String
    var color: String
}

struct FinanceValues {
    static let values = [
        Finance(image: "house.circle.fill", title: "Дом", price: 321, category: "Продукты", color: "yellow"),
        Finance(image: "cart.circle.fill", title: "Покупки", price: 574, category: "Одежда", color: "indigo"),
        Finance(image: "car.circle.fill", title: "Транспорт", price: 124, category: "Такси", color: "green"),
        Finance(image: "heart.circle.fill", title: "Здоровье", price: 765, category: "Лечение", color: "purple"),
        Finance(image: "figure.walk.circle.fill", title: "Фитнес", price: 324, category: "Тренировки", color: "blue"),
        Finance(image: "creditcard.circle.fill", title: "Счета", price: 726, category: "Комунальные", color: "yellow"),
        Finance(image: "message.circle.fill", title: "Ресторан", price: 325, category: "Ужин", color: "green")
    ]
}
