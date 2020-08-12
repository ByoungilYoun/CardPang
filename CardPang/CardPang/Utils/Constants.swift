//
//  Constants.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/12.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation
import Firebase

let Msg_Cardgame = "카드게임"
let Msg_Memory = "기억력 항샹"
let Msg_TimeLimit = "제한 시간"

let Discription_Cardgame = "똑같은 그림을 최대한 빨리 매칭시켜 보세요!"
let Discription_Memory = "카드 게임을 통해 기억력 항샹!"
let Discription_TimeLimit = "제한 시간 안에 게임을 끝내보세요!"

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
