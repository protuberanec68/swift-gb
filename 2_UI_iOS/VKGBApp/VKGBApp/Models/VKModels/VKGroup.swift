//
//  VKGroup.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 08.10.2021.
//

import UIKit

struct VKGroups: Decodable {
    let items: [VKGroup]
}

struct VKGroup {
    let id: Int
    let name: String
    let isMember: Bool
    let photoURL: URL?
    let description: String
}

extension VKGroup: Decodable {
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case isMember = "is_member"
        case photo = "photo_100"
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(
            Int.self,
            forKey: .id)
        self.name = try container.decode(
            String.self,
            forKey: .name)
        let tempIsMember = try container.decode(
            Int.self,
            forKey: .isMember)
        self.isMember = Bool(
            truncating: NSNumber(
                integerLiteral: tempIsMember))
        let url = try container.decode(
            String.self,
            forKey: .photo)
        self.photoURL = URL(string: url)
        if container.contains(.description) {
            self.description = try container.decode(
                String.self,
                forKey: .description)
        } else {
            self.description = ""
        }
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.isMember = false
        self.photoURL = nil
        self.description = ""
    }
}


/*
 groups.get
 {
     "response": {
         "count": 2,
         "items": [
             {
                 "id": 40215828,
                 "name": "Планета Кунцево",
                 "screen_name": "kynts",
                 "is_closed": 0,
                 "type": "page",
                 "is_admin": 0,
                 "is_member": 1,
                 "is_advertiser": 0,
                 "photo_50": "https://sun1-90.userapi.com/s/v1/ig2/E8c0CoVdgNbC2MSec9cSKWbAGx6qt2sTp-I8LN35xMx1fHfpHtSj5xlmWcCbx7NNMcfudA_YCv4g2XMCoEhIvkG7.jpg?size=50x50&quality=95&crop=0,0,467,467&ava=1",,
                 "description": "ПОДОЗРЕВАЕТЕ У СЕБЯ КОВИД?\n - сдайте тест на коронавирус: mosgorzdrav.ru/covid-test\nЕСЛИ ВЫ ЗАБОЛЕЛИ КОВИДОМ\n- не занимайтесь самолечением и вызовите врача: mosgorzdrav.ru/coronavirus-covid-19\nЕСЛИ ВЫ ПЕРЕБОЛЕЛИ КОВИДОМ\n- сдайте плазму: mosgorzdrav.ru/plazma\nГОРЯЧАЯ ЛИНИЯ ПО КОРОНАВИРУСУ: 8-495-870-45-09\nНОВОСТИ О COVID-19 У ОПЕРШТАБА: vk.com/covid2019_official, t.me/COVID2019_official\n\n***\nНа планете Кунцево самые кульные куницы!\n\n-\n\n-\n\n-\n\nКропоткинская\nКунцевская\nМолодежная"
             },
         ]
     }
 }
 
 
 
 groups.search

 {
     "response": {
         "count": 151280,
         "items": [
             {
                 "id": 107932994,
                 "name": "Спортивный клуб \"Ромашково\"",
                 "screen_name": "skromashkovo",
                 "is_closed": 0,
                 "type": "page",
                 "is_admin": 0,
                 "is_member": 1,
                 "is_advertiser": 0,
                 "photo_50": "https://sun1-89.userapi.com/s/v1/if1/15T3zXJDyenN0RTvmznB4rF1Vg2dths7ikEmEewchwsXtGOz9EqDYgrkGa7MVGrVeXBbEr9R.jpg?size=50x50&quality=96&crop=0,0,200,200&ava=1",
                 "photo_100": "https://sun1-89.userapi.com/s/v1/if1/5OIMrMqhjJYcmPco8qlmGk7urr0S_Rf8hnmdmCJaXYr-q_2ZM_OwOv6vZSpwxNfdwwyToF0N.jpg?size=100x100&quality=96&crop=0,0,200,200&ava=1",
                 "photo_200": "https://sun1-89.userapi.com/s/v1/if1/snzNKQXT7ahu8IKISgOkLawU48xiWKikTF6QT5vXvbjLvpa8uZQo3sS5dZScNWthZ8H8Zg4I.jpg?size=200x200&quality=96&crop=0,0,200,200&ava=1",
                 "description": "СК «Ромашково» объединяет любителей активных видов спорта, лыжников, велосипедистов и бегунов. Все желающие могут тренироваться и участвовать в интересных соревнованиях (лыжные гонки, МТБ, кросс, триатлон, спортивное ориентирование), а также выступать в команде клуба в любом виде спорта."
             },
             {
                 "id": 47610600,
                 "name": "СПОРТ",
                 "screen_name": "ya.sportivnaya",
                 "is_closed": 0,
                 "type": "page",
                 "is_admin": 0,
                 "is_member": 0,
                 "is_advertiser": 0,
                 "photo_50": "https://sun1-89.userapi.com/s/v1/ig2/tYFL_uVmOYq0Rzj8MQ-Vq3-qKlj2lHK0skA3dY18pfrROkHIVBmetigi_JTgiqI-osveSc2VAy-oAocreFY2o4Tv.jpg?size=50x50&quality=96&crop=80,377,569,569&ava=1",
                 "photo_100": "https://sun1-89.userapi.com/s/v1/ig2/zMfVZ4PLzxsWavAQHRLGxuDoMKWV2uVpwiup41wTk1xzNb_Gwmv2iR1JmLDppIfY3Se3Ho1kjFDR7wmenJU-p2Kj.jpg?size=100x100&quality=96&crop=80,377,569,569&ava=1",
                 "photo_200": "https://sun1-89.userapi.com/s/v1/ig2/aVXferve3wmKgQe1uE3L6Hm_uxbAHFmkC03ewBIFDQSR2dbCPymhMDvBigyqVDbUe_x1WfGGpQlg5qJ_EHPYopTc.jpg?size=200x200&quality=96&crop=80,377,569,569&ava=1",
                 "description": "Это один из самых больших пабликов \nвконтакте о спорте, мотивации и правильном питании🥗"
             }
         ]
     }
 }
 
 */
