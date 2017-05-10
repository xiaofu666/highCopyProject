//
//  XHBGomokuChessModelTemplate.m
//  XHBGomoku
//
//  Created by weqia on 14-9-3.
//  Copyright (c) 2014年 xhb. All rights reserved.
//


#define First_Five  3000000
#define First_Four_live  300000
#define First_Four_resh  2000
#define First_Three_live 1000
#define First_Three_resh 100
#define First_Two_live  100
#define First_Two_resh 6

#define Second_Five  1000000
#define Second_Four_live  50000
#define Second_Four_resh  1000
#define Second_Three_live 500
#define Second_Three_resh 50
#define Second_Two_live  20
#define Second_Two_resh 0
#define Second_One 5

#import "XHBGomokuChessModelTemplate.h"
#import "XHBGomokuGameEngine.h"
@interface XHBGomokuChessModelTemplate ()
@end

@implementation XHBGomokuChessModelTemplate


+(instancetype)shareTemplete
{
    static XHBGomokuChessModelTemplate * templete=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        templete=[[XHBGomokuChessModelTemplate alloc]init];
    });
    return templete;
}


-(NSInteger)calculateScoreWithModelValue:(long long)modelValue
{
    if (modelValue==0) {
        return 0;
    }
    NSInteger maxFirstValue=0;
    NSInteger maxSecondValue=0;
    while (modelValue>216) {
        NSInteger valueFirst=[self calculateFirst:modelValue];
        NSInteger valueSecond=[self calculateSecond:modelValue];
        maxFirstValue=maxFirstValue>valueFirst?maxFirstValue:valueFirst;
        maxSecondValue=maxSecondValue>valueSecond?maxSecondValue:valueSecond;
        modelValue=modelValue>>2;
    }
  //  printf("First :%d   Second:%d\n",maxFirstValue,maxSecondValue);
    NSInteger score;
    if ([[XHBGomokuGameEngine game].envisionStack depth]%2==0) {
        score= maxFirstValue-maxSecondValue;
    }else{
        score= maxSecondValue-maxFirstValue;
    }
    return score;
}

-(NSInteger)calculateFirst:(long long)modelValue
{
    // 最后一子是电脑下的，并且我是黑子 （白子为进攻）
    if ([XHBGomokuGameEngine game].playerFirst&&[[XHBGomokuGameEngine game].envisionStack depth]%2==0) {
        if ([self white_five:modelValue]) {
            return First_Five;
        }else if([self white_four_live:modelValue]){
            return First_Four_live;
        }else if([self white_four_resh:modelValue]){
            return First_Four_resh;
        }else if([self white_three_live:modelValue]){
            return First_Three_live;
        }else if([self white_three_resh:modelValue]){
            return First_Three_resh;
        }else if([self white_two_live:modelValue]){
            return First_Two_live;
        }else if([self white_two_resh:modelValue]){
            return First_Two_resh;
        }
    }else{
        if ([self black_five:modelValue]) {
            return First_Five;
        }else if([self black_four_live:modelValue]){
            return First_Four_live;
        }else if([self black_four_resh:modelValue]){
            return First_Four_resh;
        }else if([self black_three_live:modelValue]){
            return First_Three_live;
        }else if([self black_three_resh:modelValue]){
            return First_Three_resh;
        }else if([self black_two_live:modelValue]){
            return First_Two_live;
        }else if([self black_two_resh:modelValue]){
            return First_Two_resh;
        }
    }
    return 0;
}
-(NSInteger)calculateSecond:(long long)modelValue
{
    // 我是黑子， 最后一子是电脑下得 （对黑子是防守）
    if ([XHBGomokuGameEngine game].playerFirst&&[[XHBGomokuGameEngine game].envisionStack depth]%2==0) {
        if ([self black_five:modelValue]) {
            return Second_Five;
        }else if([self black_four_live:modelValue]){
            return Second_Four_live;
        }else if([self black_four_resh:modelValue]){
            return Second_Four_resh;
        }else if([self black_three_live:modelValue]){
            return Second_Three_live;
        }else if([self black_three_resh:modelValue]){
            return Second_Three_resh;
        }else if([self black_two_live:modelValue]){
            return Second_Two_live;
        }else if([self black_two_resh:modelValue]){
            return Second_Two_resh;
        }else if([self black_one:modelValue]){
            return Second_One;
        }
    }else{
        if ([self white_five:modelValue]) {
            return Second_Five;
        }else if([self white_four_live:modelValue]){
            return Second_Four_live;
        }else if([self white_four_resh:modelValue]){
            return Second_Four_resh;
        }else if([self white_three_live:modelValue]){
            return Second_Three_live;
        }else if([self white_three_resh:modelValue]){
            return Second_Three_resh;
        }else if([self white_two_live:modelValue]){
            return Second_Two_live;
        }else if([self white_two_resh:modelValue]){
            return Second_Two_resh;
        }else if([self white_one:modelValue]){
            return Second_One;
        }
    }
    return 0;
}



-(BOOL)black_five:(long long)value
{
    if ((value&0x3ff)==Black_Five) {
        return YES;
    }
    return NO;
}
-(BOOL)black_four_live:(long long)value
{
    if ((value&0xfff)==Black_Four_live) {
        return YES;
    }
    return NO;
}
-(BOOL)black_four_resh:(long long)value
{
    if ((value&0x3ff)==Black_Four_rush_1) {
        return YES;
    }else if ((value&0x3ff)==Black_Four_rush_2) {
        return YES;
    }else if ((value&0x3ff)==Black_Four_rush_3) {
        return YES;
    }else if ((value&0x3ff)==Black_Four_rush_4) {
        return YES;
    }else if ((value&0x3ff)==Black_Four_rush_5) {
        return YES;
    }
    return NO;
}
-(BOOL)black_three_live:(long long)value
{
    if ((value&0xfff)==Black_Three_live_1) {
        return YES;
    }else if ((value&0xfff)==Black_Three_live_2) {
        return YES;
    }else if ((value&0xfff)==Black_Three_live_3) {
        return YES;
    }else if ((value&0xfff)==Black_Three_live_4) {
        return YES;
    }
    return NO;
}
-(BOOL)black_three_resh:(long long)value
{
    if ((value&0x3ff)==Black_Three_resh_1) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_2) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_3) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_4) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_5) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_6) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_7) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_8) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_9) {
        return YES;
    }else if ((value&0x3ff)==Black_Three_resh_10) {
        return YES;
    }
    return NO;
}
-(BOOL)black_two_live:(long long)value
{
    if ((value&0xfff)==Black_Two_live_1) {
        return YES;
    }else if ((value&0xfff)==Black_Two_live_2) {
        return YES;
    }else if ((value&0xfff)==Black_Two_live_3) {
        return YES;
    }else if ((value&0xfff)==Black_Two_live_4) {
        return YES;
    }else if ((value&0xfff)==Black_Two_live_5) {
        return YES;
    }else if ((value&0xfff)==Black_Two_live_6) {
        return YES;
    }
    return NO;
}
-(BOOL)black_two_resh:(long long)value
{
    if ((value&0x3ff)==Black_Two_resh_1) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_2) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_3) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_4) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_5) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_6) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_7) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_8) {
        return YES;
    }else if ((value&0x3ff)==Black_Two_resh_9) {
        return YES;
    }
    return NO;
}

-(BOOL)black_one:(long long)value
{
    if ((value&0xfff)==Black_One_1) {
        return YES;
    }else if ((value&0xfff)==Black_One_2) {
        return YES;
    }
    return NO;
}


-(BOOL)white_five:(long long)value
{
    if ((value&0x3ff)==White_Five) {
        return YES;
    }
    return NO;
}
-(BOOL)white_four_live:(long long)value
{
    if ((value&0xfff)==White_Four_live) {
        return YES;
    }
    return NO;
}
-(BOOL)white_four_resh:(long long)value
{
    if ((value&0x3ff)==White_Four_rush_1) {
        return YES;
    }else if ((value&0x3ff)==White_Four_rush_2) {
        return YES;
    }else if ((value&0x3ff)==White_Four_rush_3) {
        return YES;
    }else if ((value&0x3ff)==White_Four_rush_4) {
        return YES;
    }else if ((value&0x3ff)==White_Four_rush_5) {
        return YES;
    }
    return NO;
}
-(BOOL)white_three_live:(long long)value
{
    if ((value&0xfff)==White_Three_live_1) {
        return YES;
    }else if ((value&0xfff)==White_Three_live_2) {
        return YES;
    }else if ((value&0xfff)==White_Three_live_3) {
        return YES;
    }else if ((value&0xfff)==White_Three_live_4) {
        return YES;
    }
    return NO;
}
-(BOOL)white_three_resh:(long long)value
{
    if ((value&0x3ff)==White_Three_resh_1) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_2) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_3) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_4) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_5) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_6) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_7) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_8) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_9) {
        return YES;
    }else if ((value&0x3ff)==White_Three_resh_10) {
        return YES;
    }
    return NO;
}
-(BOOL)white_two_live:(long long)value
{
    if ((value&0xfff)==White_Two_live_1) {
        return YES;
    }else if ((value&0xfff)==White_Two_live_2) {
        return YES;
    }else if ((value&0xfff)==White_Two_live_3) {
        return YES;
    }else if ((value&0xfff)==White_Two_live_4) {
        return YES;
    }else if ((value&0xfff)==White_Two_live_5) {
        return YES;
    }else if ((value&0xfff)==White_Two_live_6) {
        return YES;
    }
    return NO;
}
-(BOOL)white_two_resh:(long long)value
{
    if ((value&0x3ff)==White_Two_resh_1) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_2) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_3) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_4) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_5) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_6) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_7) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_8) {
        return YES;
    }else if ((value&0x3ff)==White_Two_resh_9) {
        return YES;
    }
    return NO;
}

-(BOOL)white_one:(long long)value
{
    if ((value&0xfff)==White_One_1) {
        return YES;
    }else if ((value&0xfff)==White_One_2) {
        return YES;
    }
    return NO;
}


@end
