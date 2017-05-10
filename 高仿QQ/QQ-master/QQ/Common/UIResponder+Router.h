//
//  UIResponder+UIResponder_Router.h
//  QQ
//
//  Created by weida on 15/8/19.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>

/**
 *  @brief  聊天界面各种点击事件
 */
typedef NS_OPTIONS(NSInteger, EventChatCellType)
{
    /**
     *  删除事件
     */
    EventChatCellRemoveEvent,
    
    /**
     *  @brief  图片点击事件
     */
    EventChatCellImageTapedEvent,
    
    /**
     *  @brief  头像点击事件
     */
    EventChatCellHeadTapedEvent,
    
    /**
     *  @brief  头像长按事件
     */
    EventChatCellHeadLongPressEvent,

    /**
     *  @brief  输入框点击发送消息事件
     */
    EventChatCellTypeSendMsgEvent,
    
    
    /**
     *  @brief 输入界面，更多界面，选择图片
     */
    EventChatMoreViewPickerImage,
};

#define kModelKey      (@"model")


@interface UIResponder (Router)

/**
 *  发送一个路由器消息, 对eventName感兴趣的 UIResponsder 可以对消息进行处理
 *
 *  @param eventName 发生的事件名称
 *  @param userInfo  传递消息时, 携带的数据, 数据传递过程中, 会有新的数据添加
 *
 */
- (void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo;

@end
