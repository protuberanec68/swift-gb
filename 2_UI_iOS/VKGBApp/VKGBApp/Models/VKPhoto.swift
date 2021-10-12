//
//  VKPhoto.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 09.10.2021.
//

import Foundation

import UIKit

struct VKPhotos: Decodable {
    var items: [VKPhoto]
}

struct VKPhoto {
    var sizes: [VKPhotoSize]
    var isLiked: Bool
    var countLikes: Int
}

struct VKPhotoSize {
    let url: URL?
    let sizeType: String
}

extension VKPhoto: Decodable {
    enum CodingKeys: String, CodingKey{
        case likes
        case sizes
        }
    
    enum LikesCodingKeys: String, CodingKey{
        case isLiked = "user_likes"
        case countLikes = "count"
    }
    
    enum SizesCodingKeys: String, CodingKey{
        case url
        case sizeType = "type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(
            keyedBy: CodingKeys.self)
        let likesContainer = try container.nestedContainer(
            keyedBy: LikesCodingKeys.self,
            forKey: .likes)
        self.countLikes = try likesContainer.decode(
            Int.self,
            forKey: .countLikes)
        let tempIsLiked = try likesContainer.decode(
            Int.self,
            forKey: .isLiked)
        self.isLiked = Bool(
            truncating: NSNumber(
                value: tempIsLiked))
        var sizesContainer = try container.nestedUnkeyedContainer(
            forKey: .sizes)
        self.sizes = []
        while (!sizesContainer.isAtEnd) {
            let sizeContainer = try sizesContainer.nestedContainer(
                keyedBy: SizesCodingKeys.self)
            let tempUrlString = try sizeContainer.decode(
                String.self,
                forKey: .url)
            let tempUrl = URL(string: tempUrlString)
            let tempSizeType = try sizeContainer.decode(
                String.self,
                forKey: .sizeType)
            self.sizes.append(
                VKPhotoSize(
                    url: tempUrl,
                    sizeType: tempSizeType))
            
        }
    }
    
}

/*
photos.getAll

{
    "response": {
        "count": 4,
        "items": [
            {
                "album_id": 281018224,
                "date": 1633073732,
                "id": 457239021,
                "owner_id": 677506695,
                "has_tags": false,
                "sizes": [
                    {
                        "height": 130,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=97x130&quality=96&sign=8fceccad6c8d3ff63a7b2d403e00f82f&c_uniq_tag=xCXloQdxZAItTzSt9Kqqb_kkCxqgNf9XfG19Kf_shYA&type=album",
                        "type": "m",
                        "width": 97
                    },
                    {
                        "height": 173,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=130x173&quality=96&sign=79c83b4e67fed45f4c30330793d7bbfe&c_uniq_tag=ukJAXDIqQVMGZpDmAfDF7FE2sykLjRsalBlZLRleL9g&type=album",
                        "type": "o",
                        "width": 130
                    },
                    {
                        "height": 267,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=200x267&quality=96&sign=52f2ad8d790de36c5aad4d4490bee0ea&c_uniq_tag=qy5gAHC8PBGrwmi18rxoXtb0vsB6HaqANuUzc-tE414&type=album",
                        "type": "p",
                        "width": 200
                    },
                    {
                        "height": 427,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=320x427&quality=96&sign=50b8c7f893e6b3398b982a7be7460c5d&c_uniq_tag=L3mh6HtHVVHXde7tBN0k57id1i0a9VCWw80zaHt6Svw&type=album",
                        "type": "q",
                        "width": 320
                    },
                    {
                        "height": 680,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=510x680&quality=96&sign=13ae7585bea926cc8f62dcb44905d294&c_uniq_tag=uBIFiz12LqT928alSjBtFGWNK2Thc4h-csNTNbr6-Wo&type=album",
                        "type": "r",
                        "width": 510
                    },
                    {
                        "height": 75,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=56x75&quality=96&sign=483f9172a9abfafd5797ff05f6727cf5&c_uniq_tag=DgSm_OT1kl_uSwCcy2-i2CPaH3Pc-IZg0HAgfv-Pfso&type=album",
                        "type": "s",
                        "width": 56
                    },
                    {
                        "height": 2160,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=1620x2160&quality=96&sign=2c6435b3b18d61d97214c04005fddd37&c_uniq_tag=rSLKy-SD7g643sx0B-oedZ6yfdBn15MYuqEImse800k&type=album",
                        "type": "w",
                        "width": 1620
                    },
                    {
                        "height": 604,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=453x604&quality=96&sign=f50814ae84a2f58052d77c490cafefc4&c_uniq_tag=T6cX58iOpvWvdW8w6-fYfBSR4ppCl6JfMJWQoxpwcUQ&type=album",
                        "type": "x",
                        "width": 453
                    },
                    {
                        "height": 807,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=605x807&quality=96&sign=d82bef6ba56ef36a521baf4af79e74ab&c_uniq_tag=zh7LFg1iqAIeLgFA6yq1VxhE282FotIsAel01icNISM&type=album",
                        "type": "y",
                        "width": 605
                    },
                    {
                        "height": 1080,
                        "url": "https://sun9-61.userapi.com/impg/E6fgP-CQTWIc6fU3fc9l00e3lA0KnMws334VDw/glVNQ31eZFw.jpg?size=810x1080&quality=96&sign=63121e2914ec44700133c181d31a2a9d&c_uniq_tag=DDBGsJss5r6d5J7GdDgnLXQzbkVfzunAqOBiPCfMbOk&type=album",
                        "type": "z",
                        "width": 810
                    }
                ],
                "text": "",
                "likes": {
                    "user_likes": 0,
                    "count": 0
                },
                "reposts": {
                    "count": 0
                }
            }
        ]
    }
}

*/
