//
//  Constants.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/12.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation
import Firebase

let Msg_Cardgame = "카드 맞추기"
let Msg_Memory = "기억력 항샹"
let Msg_TimeLimit = "제한 시간"

let Discription_Cardgame = "Easy, Normal, Hard 모드에 따라 원하는 게임 플레이!\n선택시 바로 게임이 실행되니 주의하세요. 🤗"
let Discription_Memory = "카드 게임을 통해 기억력 향상시켜보세요! 💁🏻"
let Discription_TimeLimit = "제한 시간 안에 게임을 끝내보세요!\nEasy(30초), Normal(40초), Hard(50초) ⏱"

let MSG_RESET_PASSWORD_LINK_SENT = "해당 이메일로 초기화 링크를 보내드렸습니다."
let MSG_NOT_RIGHT_EMAIL_OR_PASSWORD = "이메일 또는 비밀번호가 잘못된 형식입니다."
let MSG_NOT_RIGHT_EMAIL = "잘못된 이메일 형식입니다."

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let myBlueColor = UIColor(red: 56 / 255, green: 181 / 255, blue: 253 / 255, alpha: 1)
let myGreenColor = UIColor(red: 126 / 255, green: 217 / 255, blue: 87 / 255, alpha: 1)
let myYellowColor = UIColor(red: 254 / 255, green: 222 / 255, blue: 89 / 255, alpha: 1)
