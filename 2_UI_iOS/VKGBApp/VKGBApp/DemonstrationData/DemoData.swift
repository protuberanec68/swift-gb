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

let groups: [Int:Group] = [
    23:Group(
        "Коллаборация",
        "Мы за объединение всех объединений!",
        UIImage(named: "union")),
    56:Group(
        "Прокрастинация",
        "Вливайся!",
        UIImage(named: "fine")),
    143:Group(
        "Bash.org",
        "Цитаты из мира интернета",
        UIImage(named: "bashorg"))
]

var myGroupsID = [23, 56]

var isPostLiked = false
var likesPostCount = 236
