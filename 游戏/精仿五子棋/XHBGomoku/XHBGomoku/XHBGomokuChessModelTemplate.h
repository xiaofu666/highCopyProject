//
//  XHBGomokuChessModelTemplate.h
//  XHBGomoku
//
//  Created by weqia on 14-9-3.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * 棋型模板 
 *
 *  每一个棋的状态可由两位的比特位来表示  11, 10 ,01
 *  XHBGomokuChessTypeBlack (黑棋)   01   ==1
 *
 *  XHBGomokuChessTypeWhite (白棋)   10   ==2
 *
 *  XHBGomokuChessTypeEmpty (空位)   11   ==3
 */


/**
 *   每种棋型的棋型代码(黑棋 ：b ,  白棋 ：w ， 空格：-  )
 */



#define White_Five    0x2aa        //白子五连   w w w w w     10 10 10 10 10


#define White_Four_live  0xeab     //白子活四   - w w w w -     11 10 10 10 10 11   e a b



//冲四
#define White_Four_rush_1  0x3aa       //白子冲四  - w w w w     11 10 10 10 10  3 a a

#define White_Four_rush_2  0x2ea       //白子冲四  w - w w w    10 11 10 10 10  2 e a

#define White_Four_rush_3  0x2ba       //白子冲四  w w - w w    10 10 11 10 10  2 b a

#define White_Four_rush_4  0x2ae       //白子冲四  w w w - w    10 10 10 11 10  2 a e

#define White_Four_rush_5  0x2ab       //白子冲四  w w w w -    10 10 10 10 11  2 a b


// 活三
#define White_Three_live_1  0xfab      //白子活三   - - w w w -  11 11 10 10 10 11  f a b

#define White_Three_live_2  0xeeb      //白子活三  - w - w w -  11 10 11 10 10 11  e e b

#define White_Three_live_3  0xebb      //白子活三  - w w - w -  11 10 10 11 10 11  e b b

#define White_Three_live_4  0xeae      //白子活三  - w w w - w  11 10 10 10 11 10  e a e


// 冲三

#define White_Three_resh_1  0x3ea      //白子冲三    - - w w w   3 e a

#define White_Three_resh_2  0x3ab       //白子冲三    - w w w -   3 a b

#define White_Three_resh_3  0x2af       //白子冲三    w w w - -   2 a f

#define White_Three_resh_4  0x3ba      //白子冲三    - w - w w   3 b a

#define White_Three_resh_5  0x3ae     //白子冲三    - w w - w   3 a e

#define White_Three_resh_6  0x2bb     //白子冲三    w w - w -   2 b b

#define White_Three_resh_7  0x2eb      //白子冲三    w - w w -   2 e b

#define White_Three_resh_8  0x2be      //白子冲三    w w - - w   2 b e

#define White_Three_resh_9  0x2fa      //白子冲三    w - - w w   2 f a

#define White_Three_resh_10  0x2ee      //白子冲三   w - w - w   2 e e


// 活二

#define White_Two_live_1    0xfeb      //白子活二    - - - w w -    f e b

#define White_Two_live_2    0xfaf      //白子活二    - - w w - -    f a f

#define White_Two_live_3    0xebf      //白子活二    - w w - - -    e b f

#define White_Two_live_4    0xfbb      //白子活二    - - w - w -    f b b

#define White_Two_live_5    0xeef      //白子活二    - w - w - -    e e f

#define White_Two_live_6    0xefb     //白子活二    - w - - w -    e f b


// 冲二


#define White_Two_resh_1    0xefa      //白子冲二    - - - w w   3 f a

#define White_Two_resh_2    0x3eb      //白子冲二    - - w w -   3 e b

#define White_Two_resh_3    0x3af      //白子冲二    - w w - -   3 a f

#define White_Two_resh_4    0x2bf      //白子冲二    w w - - -   2 b f

#define White_Two_resh_5    0x3ee     //白子冲二    - - w - w   3 e e

#define White_Two_resh_6    0x3bb     //白子冲二    - w - w -   3 b b

#define White_Two_resh_7    0x2ef      //白子冲二    w - w - -   2 e f

#define White_Two_resh_8    0x3be      //白子冲二    - w - - w   3 b e

#define White_Two_resh_9    0x2fb      //白子冲二    w - - w -   2 f b


//活一

#define White_One_1  0xeff  //白子活一         - w - - - -   eff

#define White_One_2  0xffb   //白子活一        - - - - w -   ffb



#define Black_Five    0x155        //黑子五连   b b b b b         155


#define Black_Four_live  0xd57     //黑子活四   - b b b b -     d57

//冲四
#define Black_Four_rush_1  0x355       //黑子冲四  - b b b b   355

#define Black_Four_rush_2  0x1d5       //黑子冲四  b - b b b   1d5

#define Black_Four_rush_3  0x175       //黑子冲四  b b - b b   175

#define Black_Four_rush_4  0x15d       //黑子冲四  b b b - b   15d

#define Black_Four_rush_5  0x157       //黑子冲四  b b b b -   157


// 活三
#define Black_Three_live_1  0xf57      //黑子活三  - - b b b -  f57

#define Black_Three_live_2  0xdd7      //黑子活三  - b - b b -  dd7

#define Black_Three_live_3  0xd77      //黑子活三  - b b - b -  d77

#define Black_Three_live_4  0xd5d      //黑子活三  - b b b - b  d5d


// 冲三

#define Black_Three_resh_1  0x3d5      //黑子冲三    - - b b b  3d5

#define Black_Three_resh_2  0x357       //黑子冲三    - b b b -   357

#define Black_Three_resh_3  0x15f       //黑子冲三    b b b - -    15f

#define Black_Three_resh_4  0x375      //黑子冲三    - b - b b     375

#define Black_Three_resh_5  0x35d     //黑子冲三    - b b - b     35d

#define Black_Three_resh_6  0x177     //黑子冲三    b b - b -    177

#define Black_Three_resh_7  0x1d7      //黑子冲三    b - b b -   1d7

#define Black_Three_resh_8  0x17d      //黑子冲三    b b - - b   17d

#define Black_Three_resh_9  0x1f5      //黑子冲三    b - - b b   1f5

#define Black_Three_resh_10  0x1dd      //黑子冲三   b - b - b   1dd


// 活二

#define Black_Two_live_1    0xfd7      //黑子活二    - - - b b -   fd7

#define Black_Two_live_2    0xf5f      //黑子活二    - - b b - -   f5f

#define Black_Two_live_3    0xd7f      //黑子活二    - b b - - -   d7f

#define Black_Two_live_4    0xf77      //黑子活二    - - b - b -   f77

#define Black_Two_live_5    0x77f      //黑子活二    - b - b - -   77f

#define Black_Two_live_6    0xdf7     //黑子活二    - b - - b -    df7


// 冲二


#define Black_Two_resh_1    0x3f5      //黑子冲二    - - - b b   3f5

#define Black_Two_resh_2    0x3d7      //黑子冲二    - - b b -   3d7

#define Black_Two_resh_3    0x35f      //黑子冲二    - b b - -   35f

#define Black_Two_resh_4    0x17f      //黑子冲二    b b - - -   17f

#define Black_Two_resh_5    0x3dd     //黑子冲二    - - b - b    3dd

#define Black_Two_resh_6    0x377     //黑子冲二    - b - b -    377

#define Black_Two_resh_7    0x1df      //黑子冲二    b - b - -   1df

#define Black_Two_resh_8    0x37d      //黑子冲二    - b - - b   37d

#define Black_Two_resh_9    0x1f7      //黑子冲二    b - - b -   1f7


// 活一

#define Black_One_1   0xdff   //  黑子活一  - b - - - -

#define Black_One_2   0xff7   //  黑子活一  - - - - b -


@interface XHBGomokuChessModelTemplate : NSObject

+(instancetype)shareTemplete;

-(NSInteger)calculateScoreWithModelValue:(long long)modelValue;

@end
