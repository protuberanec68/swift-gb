//
//  VKNews.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 31.10.2021.
//

import UIKit

struct VKNews {
    var items: [VKNew]
    var profiles: [VKNewsProfile]
    var groups: [VKNewsGroup]
    let nextFrom: String
    
    init?(){
        self.items = []
        self.profiles = []
        self.groups = []
        self.nextFrom = ""
    }
}

struct VKNew {
    let text: String?
    var photos: [VKNewsPhoto] = []
    var docs: [VKNewsDoc] = []

    let sourceID: Int
    let sourceType: SourceType
    
    let likesCount: Int
    let isLiked: Bool
    let repostsCount: Int
    let isReposted: Bool
    let viewsCount: Int
}

struct VKNewsPhoto {
    let sizes: [VKPhotoSize]
}

struct VKNewsDoc {
    let title: String
    let size: Int
    let url: URL?
}

struct VKNewsGroup {
    let id: Int
    let name: String
    let photoUrl: URL?
}

struct VKNewsProfile {
    let id: Int
    let firstName: String
    let lastName: String
    let photoUrl: URL?
}

extension VKNews: Decodable {
    enum CodingKeys: String, CodingKey{
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

extension VKNew: Decodable{
    enum NewCodingKeys: String, CodingKey{
        case text
        case attachments
        case sourceID = "source_id"
        case likes
        case reposts
        case views
    }
    enum LikesCodingKeys: String, CodingKey{
        case count
        case userLikes = "user_likes"
    }
    enum RepostsCodingKeys: String, CodingKey{
        case count
        case userReposted = "user_reposted"
    }
    enum ViewsCodingKeys: String, CodingKey{
        case count
    }
    
    enum AttachmentsCodingKeys: String, CodingKey{
        case type
        case photo
        case doc
    }
    
    enum DocsCodingKeys: String, CodingKey{
        case title
        case size
        case url
    }
    
    enum PhotosCodingKeys: String, CodingKey{
        case sizes
    }
    
    enum SizesCodingKeys: String, CodingKey{
        case type
        case url
    }
    
    
    enum SourceType: String{
        case profile = "profile"
        case group = "group"
        
        init?(_ param: String){
            switch param{
            case "profile":
                self = .profile
            default:
                self = .group
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewCodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        
        var attachmentsContainer = try container.nestedUnkeyedContainer(forKey: .attachments)
        while(!attachmentsContainer.isAtEnd){
            let attachmentContainer = try attachmentsContainer.nestedContainer(keyedBy: AttachmentsCodingKeys.self)
            let type = try attachmentContainer.decode(String.self, forKey: .type)
            switch type{
            case "photo":
                let photoContainer = try attachmentContainer.nestedContainer(keyedBy: PhotosCodingKeys.self, forKey: .photo)
                
                var sizesContainer = try photoContainer.nestedUnkeyedContainer(forKey: .sizes)
                var tempSizes: [VKPhotoSize] = []
                while(!sizesContainer.isAtEnd){
                    let sizeContainer = try sizesContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
                    let tempUrlString = try sizeContainer.decode(
                        String.self,
                        forKey: .url)
                    let url = URL(string: tempUrlString)
                    let type = try sizeContainer.decode(String.self, forKey: .type)
                    tempSizes.append(
                        VKPhotoSize(
                            url: url,
                            sizeType: type))
                }
                self.photos.append(VKNewsPhoto(sizes: tempSizes))
            case "doc":
                let docContainer = try attachmentContainer.nestedContainer(keyedBy: DocsCodingKeys.self, forKey: .doc)
                let title = try docContainer.decode(String.self, forKey: .title)
                let size = try docContainer.decode(Int.self, forKey: .size)
                let tempUrl = try docContainer.decode(String.self, forKey: .url)
                let url = URL(string: tempUrl)
                let doc = VKNewsDoc(title: title, size: size, url: url)
                self.docs.append(doc)
            default:
                continue
            }
        }
        
        let tempSourceID = try container.decode(Int.self, forKey: .sourceID)
        self.sourceID = abs(tempSourceID)
        self.sourceType = (tempSourceID > 0) ? SourceType.profile : SourceType.group

        
        
        let likesContainer = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likes)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .count)
        let tempIsLiked = try likesContainer.decode(Int.self, forKey: .userLikes)
        self.isLiked = Bool(truncating: NSNumber(value: tempIsLiked))
        
        let repostsContainer = try container.nestedContainer(keyedBy: RepostsCodingKeys.self, forKey: .reposts)
        self.repostsCount = try repostsContainer.decode(Int.self, forKey: .count)
        let tempIsReposted = try repostsContainer.decode(Int.self, forKey: .userReposted)
        self.isReposted = Bool(truncating: NSNumber(value: tempIsReposted))
        
        let viewsContainer = try container.nestedContainer(keyedBy: ViewsCodingKeys.self, forKey: .views)
        self.viewsCount = try viewsContainer.decode(Int.self, forKey: .count)
    }
    
}

extension VKNewsGroup: Decodable{
    enum GroupsCodingKeys: String, CodingKey{
        case id
        case name
        case photoUrl = "photo_100"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GroupsCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let tempUrl = try container.decode(String.self, forKey: .photoUrl)
        self.photoUrl = URL(string: tempUrl)
    }
}

extension VKNewsProfile: Decodable{
    enum ProfileCodingKeys: String, CodingKey{
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoUrl = "photo_100"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProfileCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        let tempUrl = try container.decode(String.self, forKey: .photoUrl)
        self.photoUrl = URL(string: tempUrl)
    }
}

/*
 Структура ответа следующая:
 в response сидят массивы items, profiles, groups, и одно значение next_from
 items - source_id(если отрицательный - это группа),date,text, массив attachments, likes, reposts, views
    attachments - type (photo, doc,audio, etc.), doc(для doc), photo(для photo) etc.
        photo - массив sizes
            sizes - type, url
        doc - title, size, url
    likes - count,user_likes
    reposts - count,user_reposted
    views - count
 profiles - id, first_name, last_name, photo_100
 groups - id, name, photo_100
 */

//{
//    "response": {
//        "items": [
//            {
//                "source_id": -144282057,
//                "date": 1635601289,
//                "can_doubt_category": false,
//                "can_set_category": false,
//                "post_type": "post",
//                "text": "Динамический блок крана КС-3577 для ТК и ППР.",
//                "marked_as_ads": 0,
//                "attachments": [
//                    {
//                        "type": "photo",
//                        "photo": {
//                            "album_id": -7,
//                            "date": 1635601289,
//                            "id": 457240538,
//                            "owner_id": -144282057,
//                            "has_tags": false,
//                            "access_key": "ffb3b7b5dd83fcb64a",
//                            "post_id": 3341,
//                            "sizes": [
//                                {
//                                    "height": 109,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=130x109&quality=96&sign=f0ad30c767ffee06abda9369aa0a2814&c_uniq_tag=v9dmMD0dmWh-uU_fO96yBvEVpVCEjevbhf3HxPRVpZE&type=album",
//                                    "type": "m",
//                                    "width": 130
//                                },
//                                {
//                                    "height": 109,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=130x109&quality=96&sign=f0ad30c767ffee06abda9369aa0a2814&c_uniq_tag=v9dmMD0dmWh-uU_fO96yBvEVpVCEjevbhf3HxPRVpZE&type=album",
//                                    "type": "o",
//                                    "width": 130
//                                },
//                                {
//                                    "height": 167,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=200x167&quality=96&sign=b96228a4ebc1e772b4fb80d51e62216e&c_uniq_tag=3fmeNVJym3ng0cOpxpqc9y8AQIVcP8HqPvsz2YVW3lY&type=album",
//                                    "type": "p",
//                                    "width": 200
//                                },
//                                {
//                                    "height": 268,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=320x268&quality=96&sign=862b8e70e8c68c7a75ae85a05095131c&c_uniq_tag=1EK6IVA3w5JMeSzRNA63NVhvePdfvZr9ksPL36iwIq8&type=album",
//                                    "type": "q",
//                                    "width": 320
//                                },
//                                {
//                                    "height": 427,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=510x427&quality=96&sign=43725de7c036de26ce21a2d0bd7267de&c_uniq_tag=oVEaf0P91JH3w_zrQ3LJMAxK9zf0RsZN1dfSx7BWMQ4&type=album",
//                                    "type": "r",
//                                    "width": 510
//                                },
//                                {
//                                    "height": 63,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=75x63&quality=96&sign=8d0c3be060ad541a247712298185d21c&c_uniq_tag=uyJ2L11t16ngOL5pZReOsD2pd5HOnp8Iis6jfvl25nM&type=album",
//                                    "type": "s",
//                                    "width": 75
//                                },
//                                {
//                                    "height": 1339,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=1600x1339&quality=96&sign=2fc5888f4bdb25f12b2e970460ac256e&c_uniq_tag=k2TLw293MUNY0MmaVEysc-M-0hgXoYFARQNPacjjuwg&type=album",
//                                    "type": "w",
//                                    "width": 1600
//                                },
//                                {
//                                    "height": 505,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=604x505&quality=96&sign=62b75cc477d5436c1fb04a87c6385b59&c_uniq_tag=kUWDNaVSCJsdWO7NK5GgqRr-behiQTI_Hm_LhYeOoE8&type=album",
//                                    "type": "x",
//                                    "width": 604
//                                },
//                                {
//                                    "height": 675,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=807x675&quality=96&sign=3b4b6b28a752763e17fcdf68a329354f&c_uniq_tag=svFD-Kqh3vktWGZhPKgP1Z-J1nG3OOR2iMbiE0xZGtU&type=album",
//                                    "type": "y",
//                                    "width": 807
//                                },
//                                {
//                                    "height": 1071,
//                                    "url": "https://sun9-70.userapi.com/impg/wB8uQIEpSorX1ENK1X8-hOaYJrmlnqydCnSkxw/XsJJEq6hcuY.jpg?size=1280x1071&quality=96&sign=df53f961eb0c2a1a118dc341274c3790&c_uniq_tag=IeK1_wQS4XnZMFyWNpXuMD2-RvNwlhghBDhNX_Y84Mk&type=album",
//                                    "type": "z",
//                                    "width": 1280
//                                }
//                            ],
//                            "text": "",
//                            "user_id": 100
//                        }
//                    },
//                    {
//                        "type": "doc",
//                        "doc": {
//                            "id": 616757744,
//                            "owner_id": 344824431,
//                            "title": "Кран КС-3577 (16т) (Дин.блок).dwg",
//                            "size": 396193,
//                            "ext": "dwg",
//                            "date": 1635601274,
//                            "type": 8,
//                            "url": "https://vk.com/doc344824431_616757744?hash=b22b84b70978de2009&dl=GY3TONJQGY3DSNI:1635618699:a4b72443494fa440ff&api=1&no_preview=1&module=feed",
//                            "access_key": "521e611d5b3ef804db"
//                        }
//                    }
//                ],
//                "post_source": {
//                    "platform": "android",
//                    "type": "api"
//                },
//                "comments": {
//                    "can_post": 1,
//                    "count": 3,
//                    "groups_can_post": true
//                },
//                "likes": {
//                    "can_like": 1,
//                    "count": 39,
//                    "user_likes": 0,
//                    "can_publish": 1
//                },
//                "reposts": {
//                    "count": 33,
//                    "user_reposted": 0
//                },
//                "views": {
//                    "count": 2600
//                },
//                "is_favorite": false,
//                "donut": {
//                    "is_donut": false
//                },
//                "short_text_rate": 0.800000,
//                "carousel_offset": 0,
//                "post_id": 3341,
//                "type": "post"
//            }
//]
//    "profiles": [
//            {
//                "first_name": "VK Administration",
//                "id": 100,
//                "last_name": "",
//                "can_access_closed": true,
//                "is_closed": false,
//                "sex": 2,
//                "screen_name": "id100",
//                "photo_50": "https://sun1-87.userapi.com/s/v1/if1/G4xihi1FT7BnS-Y0mUNUoLLVXT-48Vvd0EqjZFm_hnj4_KazXUExv8vvpCxm-y-wWkMQJJNR.jpg?size=50x50&quality=96&crop=0,0,400,400&ava=1",
//                "photo_100": "https://sun1-87.userapi.com/s/v1/if1/FPQPV_koiq2Wl3rP-mMR4pMWVfjBEbMgEpf53VqwjWE3mg3efUlWDODXclQYS6ABnmtMJD0Y.jpg?size=100x100&quality=96&crop=0,0,400,400&ava=1",
//                "online_info": {
//                    "visible": true,
//                    "is_online": false,
//                    "is_mobile": false
//                },
//                "online": 0
//            },
//            {
//                "first_name": "Alexander",
//                "id": 322797603,
//                "last_name": "Kulganek",
//                "can_access_closed": true,
//                "is_closed": false,
//                "sex": 2,
//                "screen_name": "id322797603",
//                "photo_50": "https://sun1-86.userapi.com/s/v1/if1/hgIQVMWv6-pNrYhKARb6b4_Gd-P1GLrGMd8ySU8XBvJCWAlmJh744boQl3Qc2Wy0EWq2zXyn.jpg?size=50x50&quality=96&crop=0,139,704,704&ava=1",
//                "photo_100": "https://sun1-86.userapi.com/s/v1/if1/RcCsgi3Y4jaGeD35zAu1ZZB-W6qt9Ly4LRJ3pc0Ggq4QS1DfZybu1tREkqodILjSZg0Tk37u.jpg?size=100x100&quality=96&crop=0,139,704,704&ava=1",
//                "online_info": {
//                    "visible": true,
//                    "last_seen": 1635618597,
//                    "is_online": true,
//                    "is_mobile": false
//                },
//                "online": 1
//            }
//
//        ],
//        "groups": [
//            {
//                "id": 144282057,
//                "name": "Исполнительная документация | Инженер ПТО",
//                "screen_name": "pto_ispolnitelnaya",
//                "is_closed": 0,
//                "type": "group",
//                "is_admin": 0,
//                "is_member": 0,
//                "is_advertiser": 0,
//                "photo_50": "https://sun1-47.userapi.com/s/v1/ig2/L5fMq4hJ5_iw5bxbPuC1rJqeyPdV_S_c-Wt7VeoRFtjLLDcjUHXR6Eqlo_IgIzXi7s1z88ZbyEdcdX9V335kOUGf.jpg?size=50x50&quality=96&crop=8,97,487,487&ava=1",
//                "photo_100": "https://sun1-47.userapi.com/s/v1/ig2/2dV56aOUN-BOLpS1PQpE7bZ6wt2gQA_3MCbRe_u__AI5H79fxXGDvSZcyYCXFSUsyF5X4vw0VGEpdw_8u2IwCiSz.jpg?size=100x100&quality=96&crop=8,97,487,487&ava=1",
//                "photo_200": "https://sun1-47.userapi.com/s/v1/ig2/JmUj0OztOYOX6XbPmh-OIiChrKX12UD1M1ELaglnm6mURdKntQN2CMO6xPo-Djmecebg5vGF9UELcDuwIBOdUeZ-.jpg?size=200x200&quality=96&crop=8,97,487,487&ava=1"
//            },
//        ],
//        "next_from": "10/5_-116015363_104608"
//    }
//}
