//
//  DemoData.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

let friends = [
    User(
        "Андрей",
        "Павлов",
        nil,
        nil),
    User(
        "Egor",
        "Androniev",
        nil,
        nil),
    User(
        "Андрей",
        "Атаманенко",
        "раз-раз",
        nil),
    User(
        "Petro",
        "Makarenko",
        "proto4Ka",
        UIImage(named: "dog")),
    User(
        "Сергей",
        "Петров",
        "борщ",
        UIImage(named: "soup"))
    ]

let groups: [Group] = [
    Group(
        "Коллаборация",
        "Мы за объединение всех объединений!",
        UIImage(named: "union")),
    Group(
        "Прокрастинация",
        "Вливайся!",
        UIImage(named: "fine")),
    Group(
        "Bash.org",
        "Цитаты из мира интернета",
        UIImage(named: "bashorg")),
    Group(
        "Что-то",
        nil,
        nil)
]

var myGroups = [groups[0], groups[2]]

var isPostLiked = false
var likesPostCount = 236
