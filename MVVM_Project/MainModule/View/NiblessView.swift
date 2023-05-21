//
//  NiblessView.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 15.05.2023.
//

import UIKit

// Базовый класс NiblessView
open class NiblessView: UIView {
    
    // MARK: - Методы
    
    // Инициализатор для создания представления программным путем
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Инициализатор, недоступный для использования
    // Загрузка этого представления из Nib-файла не поддерживается в пользу внедрения зависимостей через инициализатор
    @available(*, unavailable,
                message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
}
