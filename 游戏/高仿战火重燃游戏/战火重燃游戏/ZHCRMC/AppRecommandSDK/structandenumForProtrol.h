//
//  structandenumForProtrol.h
//  TestZip
//
//  Created by ran on 12-8-16.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#ifndef TestZip_structandenumForProtrol_h
#define TestZip_structandenumForProtrol_h

//begin DZPK infomation define by version,platform,language
#define DZPKVERSION                     1
#define DZPKLANGUAGE                    1
#define DZPKCLINETPLATFORM              2
#define DZPKCLIENTBUILDNUMBER           10
#define DZPKCUSTOMID                    30000
#define DZPKPRODUCTID                   1000
//end  DZPK infomation define



//request code map begin
#define REQ_LOGIN                        1
#define REQ_LOGIN_RESOURCES              2



#define REQ_PERSON_DATA_ALTER            30
#define REQ_PERSON_DATA_HEAD_NAME        31
#define REQ_PERSON_DATA                  32


#define REQ_GAME_QUICK_SERVER            40
#define REQ_GAME_QUICK                   41
#define REQ_GAME_ROOM_LIST_MATCH         42
#define REQ_GAME_ROOM_LIST_NORMAL        43
#define REQ_GAME_ENTER_ROOM              44
#define REQ_GAME_SEND_SEAT_ACTION        45
#define REQ_GAME_SEND_MSG                46
#define REQ_GAME_SEND_ACTION             47
#define REQ_GAME_SEND_ADD_CHIPS          48
#define REQ_GAME_RECV_ACTION             49
#define REQ_GAME_RECV_LEAVE              50
#define REQ_GAME_RECV_SEAT_DOWN          51
#define REQ_GAME_RECV_CARDS              52
#define REQ_GAME_RECV_WINNER             53
#define REQ_GAME_TIMEOUT_BACK            54
#define REQ_GAME_RECV_READYTIME          55
#define REQ_GAME_RECV_START_INFOR        56
#define REQ_GAME_ADD_CHIPS               57
#define REQ_GAME_RECV_MSG                58
#define REQ_GAME_CONNECT_AGAIN           59
#define REQ_GAME_SEARCH_ROOM             60
#define REQ_GAME_RECV_OUT                61

#define REQ_RECV_NEW_MSG                 90
#define REQ_RECV_GET_MSG                 91
#define REQ_GAME_RANKING                 92
#define REQ_RECOMMENDATION               93
#define REQ_FEEDBACK                     94
#define REQ_SHARE_CONTENT                95
#define REQ_SYNC_SIGNAL_RESOURCE         96
#define REQ_SYNC_SIGNAL_GAME             97
#define REQ_CONVERT                      98
#define REQ_OFFLINE                      99
#define REQ_GET_CHIPS                    100



//i366
#define REQ_LOGIN_BY_QQ_EMAIL           140
#define REQ_GET_BACK_PWD                141
#define REQ_GET_CHANGE_PWD              143
#define REQ_GET_CHARGE                  144
#define REQ_READ_CHARGE_RESULT          145
#define REQ_USER_BING_AGAIN             147
#define REQ_USER_CONNECT_RECORD         148
#define REQ_ORDER_SUCCESS               153
#define REQ_CHARGE_FOR_IPHONE           154
#define YEE_PAY_CHARGE_RESULT           158
#define REQ_CHARGE_RESULT               171
#define REQ_RECOMMEND_APP               345
#define REQ_CHANGE_PWD_BY_EMAIL         377
//#define REQ_GET_NEWPIC_ID               98
//request code map end

#define MAXDATABYTECOUNT    4*1024

#define CLIENT_UPLOAD_HEADERSIZE        30
#define SERVER_DOWNLOAD_HEADERSIZE      20

typedef struct
{
    int8_t  CheckBitOne;           //check bit 'D'
    int8_t  CheckBitTwo;           //check bit 'Z'
    int8_t  CheckBitThree;         //check bit 'P'
    int8_t  CheckBitFour;          //check bit 'K'
    int8_t    protolVersion;      //protrol version default is 0x10
    int32_t   userID;             //userID
    int8_t    language;           //user language
    int8_t    clientPlatform;     //client platform //2 is IOS
    int8_t    clientBuildNumber;  //clientbuild number
    int16_t   customId;           //custom ID
    int16_t   productID;          //product ID
    int16_t   requestCode;        //requestCode
    int16_t   packageSize;        //package size
    
    
    size_t      headSize;           //head struct size
    int8_t     reserver[10];
}DZPK_PRO_UPDOAD_HEADER;


typedef struct
{
    int8_t  CheckBitOne;           //check bit 'D'
    int8_t  CheckBitTwo;           //check bit 'Z'
    int8_t  CheckBitThree;         //check bit 'P'
    int8_t  CheckBitFour;          //check bit 'K'
    int16_t   requestCode;        //requestCode
    int8_t    packagelevel;       //package level
    int16_t   packageSize;        //package size
    size_t      headSize;           //head struct size
    int8_t     reserver[10];
}DZPK_PRO_DOWNLOAD_HEADER;





//REQ_LOGIN（1)
//struct info
typedef struct
{
    int8_t user_type;
    int8_t account_type;
    NSString *Passwd;
    NSString *account_content;
    
    
}DZPK_CLIENT_REQ_LOGIN;

typedef struct
{
    int8_t status;
    int8_t user_type;
    int32_t server_number;
    int32_t  port;
    NSString *IP;
    NSString *key;
    int32_t   user_id;
    
}DZPK_SERVER_REQ_LOGIN;


//REQ_LOGIN_RESOURCES（2）


typedef struct
{
    
    NSString  *key;
    
}DZPK_CLIENT_REQ_LOGIN_RESOURCES;

typedef struct
{
    
    int8_t   status;
    int8_t   sex;
    int8_t   msg_count;
    //int8_t   level;
    NSString  *nick;
    NSString  *head_picName;
    int8_t   *maxcards;
    int32_t   maxwin;
    int32_t   gold;
    int32_t   idou;
    int32_t   lose_number;
    int32_t   win_number;
    int32_t   max_own;
    int32_t   online_count;
    
    NSString  *fileServerIP;
    int32_t   fileServerPort;
    
    
    int     maxcardNumber;
    
}DZPK_SERVER_REQ_LOGIN_RESOURCES;

//REQ_LOGIN_BY_QQ_EMAIL(140)
typedef struct
{
    int8_t   login_type;
    NSString  *QQNumber;
    NSString  *emailaddr;
    NSString  *pwd;
    NSString  *imei;
    int32_t  versionID;
    
}DZPK_CLIENT_REQ_LOGIN_BY_QQ_EMAIL;

typedef struct
{
    int8_t   status;
    int32_t  userID;
    
}DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL;

//REQ_GET_BACK_PWD(141)
typedef struct
{
    int8_t   iType;
    NSString  *QQNumber;
    NSString  *emaliaddr;
    
}DZPK_CLIENT_REQ_GET_BACK_PWD;

typedef struct
{
    int8_t   status;
    
}DZPK_SERVER_REQ_GET_BACK_PWD;


//REQ_GET_CHANGE_PWD(143)

typedef struct
{
    int32_t   userID;
    NSString  *checkcode;
    NSString  *pwd;
    
}DZPK_CLIENT_REQ_GET_CHANGE_PWD;

typedef struct
{
    int8_t   status;
    
}DZPK_SERVER_REQ_GET_CHANGE_PWD;


//REQ_GET_CHARGE(144)
typedef struct
{
    int32_t   userID;
    int32_t   versionID;
    
}DZPK_CLIENT_REQ_GET_CHARGE;

typedef struct
{
    int8_t   status;
    NSString  *tradeID;
    NSString  *url;
    
}DZPK_SERVER_REQ_GET_CHARGE;


//REQ_READ_CHARGE_RESULT(145)
typedef struct
{
    int8_t   status;
    NSString  *tradeID;
    int32_t  iMoney;
    
}DZPK_SERVER_REQ_READ_CHARGE_RESULT;


//REQ_USER_BING_AGAIN(147)
typedef struct
{
    int8_t    iType;
    int32_t   userID;
    NSString   *phoneNum;
    NSString   *QQNumber;
    NSString   *emailAddr;
    NSString   *countrySec;
    
}DZPK_CLIENT_REQ_USER_BING_AGAIN;

typedef struct
{
    int8_t   status;
    int8_t   iType;
}DZPK_SERVER_REQ_USER_BING_AGAIN;


//REQ_USER_CONNECT_RECORD（148)
typedef struct
{
    
    NSString   *imei;
    int32_t   versionID;
    
}DZPK_CLIENT_REQ_USER_CONNECT_RECORD;

typedef struct
{
    int8_t   status;
}DZPK_SERVER_REQ_USER_CONNECT_RECORD;

//REQ_ORDER_SUCCESS(153)
typedef struct
{
    
    int32_t   userID;
    
}DZPK_CLIENT_REQ_ORDER_SUCCESS;

typedef struct
{
    int8_t   status;
    int32_t  iMoney;
    int32_t  level;
    int32_t wealth;
}DZPK_SERVER_REQ_ORDER_SUCCESS;

//REQ_CHARGE_FOR_IPHONE(154)

typedef struct
{
    
    NSString   *orderID;
    NSString   *tradeID;
    NSString   *product_ID;
    int32_t    versionID;
    NSString   *receipt;
    
}DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE;

typedef struct
{
    int8_t   status;
    int32_t  iMoney;
    NSString  *orderID;
}DZPK_SERVER_REQ_CHARGE_FOR_IPHONE;


//YEE_PAY_CHARGE_RESULT(158)
typedef struct
{
    
    NSString   *cardtype;
    NSString   *cardnum;
    NSString   *cardpwd;
    NSString   *cardMoney;
    NSString   *product_name;
    NSString   *chargemoney;
    NSString   *orderid;
    
}DZPK_CLIENT_YEE_PAY_CHARGE_RESULT;

typedef struct
{
    int8_t   status;
    NSString  *reason;
    int32_t  iMoney;
    NSString  *liftMoney;
}DZPK_SERVER_YEE_PAY_CHARGE_RESULT;

//REQ_CHARGE_RESULT(171)
typedef struct
{
    int32_t    userID;
    int32_t    channelID;
    int32_t    idou;
    int32_t    imoney;
    
    NSString   *productID;
    NSString   *orderID;
    NSString   *customID;
    
}DZPK_CLIENT_REQ_CHARGE_RESULT;

typedef struct
{
    int8_t   status;
    int32_t  moneySum;
}DZPK_SERVER_REQ_CHARGE_RESULT;

//REQ_GAME_QUICK_SERVER（40）

typedef struct
{
    int8_t   status;
    int32_t  serverid;
    NSString  *IP;
    int32_t  port;
    int32_t  roomPATH;
    int32_t  roomID;
    
    int32_t  servicecharge;
    int32_t  bringGold;
}DZPK_SERVER_REQ_GAME_QUICK_SERVER;


//REQ_GAME_QUICK（41）

typedef struct
{
    // int32_t   roomPath;
    // int32_t  roomID;
}DZPK_CLIENT_REQ_GAME_QUICK;

typedef struct
{
    int8_t   status;
    int8_t   gamestatus;
    int8_t   countdown_times;
    int32_t  bigBlind;
    int32_t  smallBlind;
    int8_t   bigIndex;
    int8_t   smallIndex;
    int8_t   bankerIndex;
    int8_t   operationID;
    int8_t   mySeatID;
    int8_t   speed;
    int32_t  *cards;
    int32_t  *playerIDArray;
    int32_t  *statusArray;
    int32_t  *anteArray;
    NSString  *nick;
    int32_t  *chipsArray;
    NSString  *headPicString;
    int32_t  *firstCardarray;
    int32_t  *SecondArray;
    int32_t  alreadAnte;
    
    int8_t   cardsNumber;
    int8_t   playerIDNumber;
    int8_t   statusArrayNumber;
    int8_t   anteArrayNumber;
    int8_t   chipsArrayNumber;
    int8_t   firstCardNumber;
    int8_t    secondCardNumber;
}DZPK_SERVER_REQ_GAME_QUICK;


//REQ_GAME_ROOM_LIST_MATCH（42）
typedef struct
{
    int8_t   status;
    int32_t  serverport;
    int32_t  serverID;
    NSString  *IP;
    int32_t  *RoomIDArray;
    int8_t  *PlayerOrCountArray;
    int8_t  *statusArray;
    int32_t  *entryfeeArray;
    int32_t  *pathArray;
    
    
    int   roomIDNumber;
    int   PlayerOrCountNumber;
    int   statusNumber;
    int   entryFeeNumber;
    int   pathArrayNumber;
}DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH;

//REQ_GAME_ROOM_LIST_NORMAL（43)
typedef struct
{
    int8_t   category;
    
    
}DZPK_CLIENT_REQ_GAME_ROOM_LIST_NORMAL;

typedef struct
{
    int8_t   status;
    int8_t   category;
    int32_t   port;
    int32_t   serverID;
    NSString    *IP;
    
    int32_t    *RoomidArray;
    int8_t     *SpeedArray;
    int32_t    *smallArray;
    int32_t    *bigArray;
    int32_t    *serverChargeArray;
    int32_t    *bringGoldArray;
    int8_t    *playerCountArray;
    int32_t     *pathArray;
    
    
    
    
    
    
    int   roomIDNumber;
    int   PlayerOrCountNumber;
    int   speedNumber;
    int   smallNumber;
    int   bigNumber;
    int   serverChargeNumber;
    int   bringGoldNumber;
    int   pathNumber;
}DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL;



//REQ_GAME_ENTER_ROOM（44）
typedef struct
{
    int32_t   roomPath;
    int32_t   roomID;
    
    int8_t    type;
    
}DZPK_CLIENT_REQ_GAME_ENTER_ROOM;

typedef struct
{
    int8_t   status;
    int8_t   gamestatus;
    int8_t   countdown_times;
    int32_t  bigBlind;
    int32_t  smallBlind;
    int8_t   bigIndex;
    int8_t   smallIndex;
    int8_t   bankerIndex;
    int8_t   operationID;
    // int8_t   mySeatID;
    int8_t   speed;
    
    
    int8_t  *cards;
    int32_t  *playerIDArray;
    int8_t  *statusArray;
    int32_t  *anteArray;
    int8_t    mySeatID;
    NSString  *nick;
    int32_t  *chipsArray;
    NSString  *headPicString;
    int8_t  *firstCardarray;
    int8_t  *SecondArray;
    int32_t  alreadAnte;
    
    int   cardsNumber;
    int   playerIDNumber;
    int   statusArrayNumber;
    int   anteArrayNumber;
    int   chipsArrayNumber;
    int   firstCardNumber;
    int    secondCardNumber;
}DZPK_SERVER_REQ_GAME_ENTER_ROOM;


//REQ_GAME_SEND_SEAT_ACTION（45）

typedef struct
{
    
    int8_t  action;
    int8_t  seatID;
    
    int32_t   roomPath;
    int32_t   roomID;
}DZPK_CLIENT_REQ_GAME_SEND_SEAT_ACTION;

typedef struct
{
    int8_t   status;
    int8_t   action;
    int32_t  tableChip;
    int32_t  leavelChips;
    
    /// int    tablechipNumber;
    //  int    leavelChipsNumber;
}DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION;


//REQ_GAME_SEND_MSG（46）

typedef struct
{
    int8_t  msgType;
    int32_t   roomPath;
    int32_t   roomID;
    NSString   *msgContent;
}DZPK_CLIENT_REQ_GAME_SEND_MSG;

typedef struct
{
    int8_t   status;
}DZPK_SERVER_REQ_GAME_SEND_MSG;


//REQ_GAME_SEND_ACTION（47）
typedef struct
{
    int8_t  action;
    int32_t   roomPath;
    int32_t   roomID;
    int32_t   anteNumber;
}DZPK_CLIENT_REQ_GAME_SEND_ACTION;

typedef struct
{
    int8_t   status;
}DZPK_SERVER_REQ_GAME_SEND_ACTION;


//REQ_GAME_RECV_ACTION（49）
typedef struct
{
    int32_t   playerID;
    int8_t     seatID;
    int8_t     action;
    int32_t    anteNumber;
    int8_t     operationID;
}DZPK_SERVER_REQ_GAME_RECV_ACTION;

//REQ_GAME_RECV_LEAVE（50）
typedef struct
{
    
    int8_t     seatID;
    int32_t    userID;
    
}DZPK_SERVER_REQ_GAME_RECV_LEAVE;


//REQ_GAME_RECV_SEAT_DOWN（51)
typedef struct
{
    int32_t    userID;
    int8_t     seatID;
    int32_t    chips;
    NSString    *headPic;
    NSString    *nick;
}DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN;


//REQ_GAME_RECV_CARDS（52）
typedef struct
{
    
    int8_t     seatID;
    int8_t    *systemIDArray;
    
    int         systemNumbeer;
}DZPK_SERVER_REQ_GAME_RECV_CARDS;


//REQ_GAME_RECV_WINNER（53）
typedef struct
{
    
    
    int8_t    *seatIDArray;
    int32_t    *playerArray;
    int32_t    *chipsArray;
    int8_t    *cardTypesArray;
    // int32_t    *isMaxWin;
    // int32_t    *isMaxCards;
    int8_t    *cardSort;
    int32_t    *allPlayerchip;
    int32_t    *allplayerID;
    
    int         seatIDNumbeer;
    int         playerNumbeer;
    int         chipsNumbeer;
    int         cardTypesNumbeer;
    // int         isMaxWinNumbeer;
    // int         isMaxCardsNumbeer;
    int         cardSortNumbeer;
    int         allPlayerChipNumber;
    int         allplayerNumber;
}DZPK_SERVER_REQ_GAME_RECV_WINNER;

//REQ_GAME_TIMEOUT_BACK（54）
typedef struct
{
    int32_t      player_iD;
    int8_t       type;
    int8_t       seatID;
    //null
}DZPK_CLIENT_REQ_GAME_TIMEOUT_BACK;

typedef struct
{
    int32_t    playerID;
    int8_t     seatID;
    
}DZPK_SERVER_REQ_GAME_TIMEOUT_BACK;

//REQ_GAME_RECV_READYTIME（55）

typedef struct
{
    int8_t     readyTime;
    
}DZPK_SERVER_REQ_GAME_RECV_READYTIME;

//REQ_GAME_RECV_START_INFOR（56）
typedef struct
{
    int8_t     bankerID;
    int8_t     bigSeatID;
    int8_t     smallSeatID;
    int8_t     operationID;
    int8_t    *firstCardArray;
    int8_t    *SecondCardArray;
    int32_t     smallChip;
    int32_t     bigChip;
    
    int        firstNumber;
    int        secondNumber;
    
}DZPK_SERVER_REQ_GAME_RECV_START_INFOR;


//REQ_GAME_ADD_CHIPS（57)

typedef struct
{
    
    int8_t     seatID;
    int32_t    anteNumber;
    
}DZPK_CLIENT_REQ_GAME_ADD_CHIPS;

typedef struct
{
    int8_t     status;
    int8_t     seatID;
    
    int32_t    playerID;
    int32_t    Chips;
    
}DZPK_SERVER_REQ_GAME_ADD_CHIPS;


//REQ_GAME_RECV_MSG（58)
typedef struct
{
    
    int8_t     seatID;
    int8_t     playerID;
    NSString*    nick;
    int8_t      msgType;
    NSString    *msgContent;
    
}DZPK_SERVER_REQ_GAME_RECV_MSG;


//REQ_GAME_CONNECT_AGAIN（59)
typedef struct
{
    int8_t   status;
    int8_t   gamestatus;
    int8_t   countdown_times;
    int32_t  bigBlind;
    int32_t  smallBlind;
    int8_t   bigIndex;
    int8_t   smallIndex;
    int8_t   bankerIndex;
    int8_t   operationID;
    // int8_t   mySeatID;
    int8_t   speed;
    
    
    int32_t  *cards;
    int32_t  *playerIDArray;
    int32_t  *statusArray;
    int32_t  *anteArray;
    NSString  *nick;
    int32_t  *chipsArray;
    NSString  *headPicString;
    int32_t  *firstCardarray;
    int32_t  *SecondArray;
    int32_t  alreadAnte;
    
    int   cardsNumber;
    int   playerIDNumber;
    int   statusArrayNumber;
    int   anteArrayNumber;
    int   chipsArrayNumber;
    int   firstCardNumber;
    int    secondCardNumber;
}DZPK_SERVER_REQ_GAME_CONNECT_AGAIN;

//REQ_GAME_SEARCH_ROOM（60）
typedef struct
{
    int8_t      roomType;
    int32_t     roomID;
    
}DZPK_CLIENT_REQ_GAME_SEARCH_ROOM;

typedef struct
{
    
    int8_t     status;
    int32_t     serverID;
    NSString*    IP;
    int32_t      port;
    int32_t      roomPath;
    int32_t      roomID;
    int8_t       type;
    int32_t      bigBlind;
    int32_t      smallBlind;
    int32_t      serverCharge;
    int32_t      bringGold;
    int32_t      playerCount;
    int32_t      roomstatus;
    int8_t       speed;
    
}DZPK_SERVER_REQ_GAME_SEARCH_ROOM;

//REQ_RECV_NEW_MSG（90）
typedef struct
{
    
    int8_t     new_msg_number;
    
}DZPK_SERVER_REQ_RECV_NEW_MSG;


//REQ_RECV_GET_MSG（91）
typedef struct
{
    
    int8_t     status;
    int8_t     *typeArray;
    NSString    *content;
    NSString    *recv_Time;
    NSString    *post_Time;
    
    
    int         typeNumber;
    
}DZPK_SERVER_REQ_RECV_GET_MSG;

//REQ_GAME_RANKING（92）
typedef struct
{
    
    int8_t     status;
    NSString    *playerNick;
    //int32_t     *levelArray;
    int32_t     *chipsArray;
    
    
    //int         levelNumber;
    int         chipsNumber;
    
}DZPK_SERVER_REQ_GAME_RANKING;

//REQ_RECOMMENDATION（93
typedef struct
{
    
    int8_t     status;
    NSString    *title;
    NSString    *logo;
    NSString    *version;
    NSString    *size;
    NSString    *url;
    int32_t*     download_number;
    int32_t*     idNumber;
    
    int       downloadCount;
    int       idCount;
    
}DZPK_SERVER_REQ_RECOMMENDATION;

//REQ_FEEDBACK（94）

typedef struct
{
    
    NSString    *content;
}DZPK_CLIENT_REQ_FEEDBACK;
typedef struct
{
    
    int8_t     status;
    
}DZPK_SERVER_REQ_FEEDBACK;


//REQ_SHARE_CONTENT（95)
typedef struct
{
    
    int8_t     status;
    NSString   *content;
    
}DZPK_SERVER_REQ_SHARE_CONTENT;

//REQ_CONVERT（98）

typedef struct
{
    
    int8_t    converType;
    int32_t   idou;
    int32_t   chips;
}DZPK_CLIENT_REQ_CONVERT;

typedef struct
{
    
    int8_t     status;
    int32_t     idou;
    int32_t     chips;
    
}DZPK_SERVER_REQ_CONVERT;


//REQ_SYNC_SIGNAL_RESOURCE(96)
typedef struct
{
    
    int8_t     status;
    int32_t    onlineCount;
    
}DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE;


//REQ_GET_CHIPS 100
typedef struct
{
    
    int8_t     status;
    int8_t    freeTimes;
    int32_t   chips;
    int32_t   allchips;
    
}DZPK_SERVER_REQ_GET_CHIPS;


//REQ_PERSON_DATA_HEAD_NAME(31)
typedef struct
{
    
    int8_t     status;
    int32_t     port;
    NSString     *IP;
    NSString     *name;
    
}DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME;

//REQ_PERSON_DATA_ALTER(30)
typedef struct
{
    NSString   *nick;
    NSString   *head_pic_name;
    int8_t      sex;
}DZPK_CLIENT_REQ_PERSON_DATA_ALTER;
typedef struct
{
    
    int8_t     status;
    
}DZPK_SERVER_REQ_PERSON_DATA_ALTER;

//REQ_PERSON_DATA(32)
typedef struct
{
    
    int8_t     status;
    int8_t     sex;
    int8_t     msg_count;
    int8_t     level;
    NSString   *nick;
    NSString   *head_pic_name;
    int8_t    *maxCards;
    int32_t    max_win;
    int32_t    chips;
    int32_t     idou;
    int32_t     lose_number;
    int32_t     win_number;
    int32_t     max_own;
    int32_t     online_count;
    
    int         maxcardNumber;
}DZPK_SERVER_REQ_PERSON_DATA;


//REQ_GAME_RECV_OUT(61)
typedef struct
{
    int8_t  type;
    
}DZPK_CLIENT_REQ_GAME_RECV_OUT;

typedef struct
{
    int8_t    type;
    int8_t    *rankingArray;
    int8_t    *indexArray;
    int32_t   *userIDArray;
    int32_t   *goldArray;
    
    
    int    rangArrayNumber;
    int    indexArrayNumber;
    int    userIDArrayNumber;
    int    goldArrayNumber;
    
}DZPK_SERVER_REQ_GAME_RECV_OUT;


#pragma mark i366 protrol
typedef struct tagVC_CLIENT_RECEIVED_PCHC_HEADER
{
    unsigned char PCHC[4]; /*Checkout Bit*/
    unsigned char PackageType; /*0 UIP,  1 GBP,  2 PP,  3 CP,
                                4 TP,   5 RDP,  6 DFP,
                                7 UFP,  8 VP,  11 AP,
                                13 FEE, 14 SMS, 15 CDP, 255 Others*/
    
    int16_t       requestCode; /* Indicate the type of request H-L */
    unsigned char PackageLevel;
    uint16_t      packageSize; /* Indicate the total size of PCHC_HEADER and DATA parts. H-L  */
    unsigned char Reserved[10];
    
    int32_t        headSize;
}I366_CLIENT_RECEIVED_PCHC_HEADER; /* 20 Bytes */




typedef struct tagVC_CLIENT_PCHC_HEADER
{
    unsigned char PCHC[4];              /*Checkout Bit*/
    unsigned char Version;              /* 0x10 */
    unsigned char PackageType;          /*0-Normal RP , 1-video RP 2-audio RP 3-text RP,255-Others */
    unsigned char LanguageID;           /*Language id of the client 1Chinese ,0 English,255Others,default 1 */
    unsigned char ClientPlatform;       /* MTK£∫1or129£¨SPT£∫2or130 SYMBIAN£∫3, Others£∫255 */
    unsigned char ClientBuildNumber;    /* øÕªß∂À∞Ê±æ∑¢≤º∫≈ */
    uint16_t      customID;             /* ∫œ◊˜∑ΩµƒŒ®“ª±Í æ H-L */
    uint16_t      productID;            /* ≤˙∆∑µƒŒ®“ª±Í æ H-L */
    uint16_t      requestCode;          /* Indicate the type of request H-L *//*unsigned char AppNumber[2];*/ /* Indicate the client app number H-L */
    uint16_t      PackageSize;          /* Indicate the total size of PCHC_HEADER and DATA parts. H-L  */
    unsigned char Reserved[13];         /*unsigned char Reserved[11];*/
    int32_t        headSize;
}I366_SERVER_UPLOAD_PCHC_HEADER; /* 30 Bytes */


//REQ_OFFLINE(99)
typedef struct
{
    int8_t  status;
}DZPK_SERVER_REQ_OFFLINE;


//REQ_RECOMMEND_APP  345 i366
typedef struct
{
    int8_t      platform;
    int32_t     userID;
    int32_t     reqnum;
    int32_t     offset;
    int32_t     productID;
}DZPK_CLIENT_REQ_RECOMMEND_APP;

typedef struct
{
    int8_t  status;
    int32_t  listNum;
    
    NSString   *appName;
    NSString   *appDescription;
    NSString   *appPicName;
    NSString   *appversion;
    
    int32_t   appUpdateYear;
    int32_t   appUpdatemonth;
    int32_t   appUpdateDay;
    int32_t   appSize;
    int32_t  totalNuml;
    
    
}DZPK_SERVER_REQ_RECOMMEND_APP;


//REQ_CHANGE_PWD_BY_EMAIL   377
typedef struct
{
    int8_t   iType;
    NSString  *strPwd;
    NSString  *strBaseEmailAdd;
    
}DZPK_CLIENT_REQ_CHANGE_PWD_BY_EMAIL;

typedef struct
{
    int8_t   status;
    
}DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL;

#endif
