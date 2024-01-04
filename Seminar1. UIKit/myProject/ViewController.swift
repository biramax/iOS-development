//
//  ViewController.swift
//  myProject
//
//  Created by Максим Бобков on 25.12.2023.
//

import UIKit

class ViewController: UIViewController {

    // Добавим лейбл
    
    /* Первый способ:
    
    private var myLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    
    func setLabel() {
        myLabel.text = "Moe приложение!"
        myLabel.textAlignment = .center
        myLabel.textColor = .white
        myLabel.backgroundColor = .blue
        view.addSubview(myLabel)
    }
    */
    
    // Второй способ (при помощи кложуры, более популярный метод):
    
    private var myLabel: UILabel = {
        let label = UILabel() // Не передаём параметр frame (расположение элемента относительно координат экрана), т.к. настраивать расположение будем через констрейнты (расположение относительно границ экрана и соседних элементов)
        label.text = "Moe приложение!"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .blue
        return label
        /* 
        В setupUI() вызовем:
            view.addSubview(myLabel)
            addConstraints() // Расположение зададим через констрейнты
        */
    }()
    
    // Добавим картинку
    
    private var myImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person"))
        image.frame = CGRect(x: 50, y: 400, width: 200, height: 200)
        image.backgroundColor = .yellow
        return image
    }()
    
    // Добавим прямоугольник
    
    private var myView: UIView = {
        let view = UIView(/* CGRect(x: 50, y: 650, width: 300, height: 200) */)
        view.frame = CGRect(x: 50, y: 650, width: 300, height: 200)
        view.backgroundColor = .red
        return view
    }()
    
    // Добавим кнопки.
    // Для одной кнопки характеристики устанавим в ф-и addButton(), её вызов поставим в ф-ю setupUI().
    // Для другой - при помощи кложуры сразу при создании переменной. Это более популярный метод.
    
    private var myButton = UIButton()
    
    // Используем "ленивое" свойство lazy - свойство, начальное значение которого не вычисляется до первого использования.
    // Иначе в строке button.addTarget слово self будет ссылаться на тип ViewController, а не на экземпляр ViewController.
    // Когда мы выносим указание характеристик кнопки в отдельный метод addButton(), то там можно указать свойство метода private.
    lazy var myButton2: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить цвет экрана", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .highlighted) // Цвет при при нажатии
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tap2), for: .touchUpInside) // .touchUpInside - когда нажали на кнопку и отпустили на ней же; .touchDown - когда нажали на кнопку
        return button
    }()
    
    // Указатель, произошло ли нажатие на кнопку
    private var isMyButton2Taped = false

    
    // MARK: viewDidLoad()
    
    // Вызывается после загрузки представления контроллера в память
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // У UIViewController есть свойство view - это представление, которым управляет контроллер, по умолчанию оно расположено на весь экран. Цвет экрана по умолчанию чёрный.
        view.backgroundColor = .white
    
        // Заголовок для экрана
        title = "ViewController"
        
        // Заголовок для меню (если не установлен, берётся как заголовок от экрана)
        tabBarItem.title = "VC"
        
        // Добавление элементов на экран (разных вью в контроллер) выносим в отдельную функцию
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(myLabel)
        view.addSubview(myImage)
        view.addSubview(myView)
        
        addButton()
        view.addSubview(myButton)
        
        view.addSubview(myButton2)
        
        addConstraints()
    }
    
    private func addButton() {
        myButton.setTitle("Перейти на новый экран", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor = .blue
        myButton.addTarget(self, action: #selector(tap), for: .touchUpInside) // .touchUpInside - когда нажали на кнопку и отпустили на ней же; .touchDown - когда нажали на кнопку
        myButton.setTitleColor(.red, for: .highlighted)
    }
    
    // Auto Layout
    
    private func addConstraints() {
        
        // Это чтобы мы могли использовать Auto Layout
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // myLabel
            
            // Отступаем от "чёлки" 20 поинтов
            myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            // Расположить центр х лейбла по центру х вью
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            myLabel.heightAnchor.constraint(equalToConstant: view.frame.size.width/4),
            
            // myButton
            
            myButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            myButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // myButton2
            
            myButton2.topAnchor.constraint(equalTo: myButton.bottomAnchor, constant: 20),
            myButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton2.leftAnchor.constraint(equalTo: view.leftAnchor),
            myButton2.rightAnchor.constraint(equalTo: view.rightAnchor),
            myButton2.rightAnchor.constraint(equalTo: view.rightAnchor),
            myButton2.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

// MARK: objc methods

// Создаём расширение для выноса всех objc-методов, чтобы лучше ориентироваться по коду
private extension ViewController {
    
    // Поведение первой кнопки
    @objc func tap() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
    
    // Поведение второй кнопки
    @objc func tap2() {
        
        isMyButton2Taped.toggle() // Чередуем true/false
        
        if isMyButton2Taped {
            view.backgroundColor = .yellow
        } else {
            view.backgroundColor = .white
        }
    }
}

// Чтобы сбоку интерактивно отображалась визуализация данного представления
#Preview {
    ViewController()
}

