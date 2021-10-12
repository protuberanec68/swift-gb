//
//  DemoData.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

let friendsG = [
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

let defaultFoto = UIImage(named: "default")!

var myGroups = [groups[0], groups[2]]

var isPostLiked = false
var likesPostCount = 236

var isPostLiked2 = false
var likesPostCount2 = 112



var friendFotos = [
    Foto(UIImage(named: "lamawomen")!, true, 10),
    Foto(UIImage(named: "redman")!, false, 103),
    Foto(UIImage(named: "oldman")!, false, 0),
    Foto(UIImage(named: "parrotman")!, true, 33),
    Foto(UIImage(named: "beerman")!, false, 10)
]
