//
//  DemoData.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

var users = [
    User(
        "Egor",
        "Androniev",
        nil,
        nil),
    User(
        "Petro",
        "Makarenko",
        "proto4Ka",
        UIImage(contentsOfFile: "dog")),
    User(
        "Сергей",
        "Петров",
        "борщ",
        UIImage(contentsOfFile: "soup"))
    ]

var groups = [
    Group(
        23,
        "Коллаборация",
        "Мы за объединение всех объединений!",
        UIImage(contentsOfFile: "union")),
    Group(
        56,
        "Прокрастинация",
        "Вливайся!",
        UIImage(contentsOfFile: "fine")),
    Group(
        143,
        "Bash.org",
        "Цитаты из мира интернета",
        UIImage(contentsOfFile: "bashorg"))
]
