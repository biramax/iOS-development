//
//  Theme.swift
//  Homework6
//
//  Created by Максим Бобков on 03.02.2024.
//

import UIKit

protocol AppTheme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}



final class Theme {
    // По умолчанию назначаем белую тему
    static var currentTheme: AppTheme = WhiteTheme()
}




final class WhiteTheme: AppTheme {
    var backgroundColor: UIColor = .white
    var textColor: UIColor = .gray
}

final class BlueTheme: AppTheme {
    var backgroundColor: UIColor = #colorLiteral(red: 0.5102659464, green: 1, blue: 0.980460465, alpha: 1)
    var textColor: UIColor = .black
}

final class GreenTheme: AppTheme {
    var backgroundColor: UIColor = #colorLiteral(red: 0, green: 1, blue: 0.4926850796, alpha: 1)
    var textColor: UIColor = .brown
}
