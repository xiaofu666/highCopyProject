//
//  SmartbiAdaPerson.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/28.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//
/*
 ret	返回码
 msg	如果ret<0，会有相应的错误信息提示，返回数据全部用UTF-8编码。
 nickname	用户在QQ空间的昵称。
 figureurl	大小为30×30像素的QQ空间头像URL。
 figureurl_1	大小为50×50像素的QQ空间头像URL。
 figureurl_2	大小为100×100像素的QQ空间头像URL。
 figureurl_qq_1	大小为40×40像素的QQ头像URL。
 figureurl_qq_2	大小为100×100像素的QQ头像URL。需要注意，不是所有的用户都拥有QQ的100x100的头像，但40x40像素则是一定会有。
 gender	性别。 如果获取不到则默认返回"男"
 is_yellow_vip	标识用户是否为黄钻用户（0：不是；1：是）。
 vip	标识用户是否为黄钻用户（0：不是；1：是）
 yellow_vip_level	黄钻等级
 level	黄钻等级
 is_yellow_year_vip	标识是否为年费黄钻用户（0：不是； 1：是）
 
 
 access_token=*************&
 oauth_consumer_key=12345&
 openid=****************
 
 */

#import <Foundation/Foundation.h>

@interface SmartbiAdaPerson : NSObject

@property (nonatomic,strong)NSString *city,*figureurl,*figureurl_1
,*figureurl_2,*figureurl_qq_2,*is_lost,*is_yellow_vip,*is_yellow_year_vip,*level,*province,*ret,*vip,*year,*yellow_vip_leve,*msg,
*figureurl_qq_1,*gender,*nickname,
*access_token,*oauth_consumer_key,*openid;

+(SmartbiAdaPerson *)initWithDictionry:(NSDictionary *)dict WithOnLine:(NSDictionary *)dictOnLine;


@end
