//
//  ChannelsTableViewCell.h
//  presents
//
//  Created by dapeng on 16/1/10.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol channelsTableViewDelegate <NSObject>

- (void)passTag:(NSInteger)tag;

@end


@interface ChannelsTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titles;
@property (nonatomic, strong) NSMutableArray *channelsArr;
@property (nonatomic, assign) id<channelsTableViewDelegate>channelsDelegate;
@end
