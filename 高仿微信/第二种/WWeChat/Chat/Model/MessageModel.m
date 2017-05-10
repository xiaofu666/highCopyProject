//
//  MessageModel.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "MessageModel.h"
@implementation MessageModel

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.bubbleSize = [self giveSizeForStr:self.message];
}

- (CGSize)giveSizeForStr:(NSString *)str
{
    UIFont * font = [UIFont systemFontOfSize:14.0];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize size = [str boundingRectWithSize:CGSizeMake(200 - 20 - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return CGSizeMake(size.width + 40, size.height + 20);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%d %@",self.isMe,self.message];
}
@end
