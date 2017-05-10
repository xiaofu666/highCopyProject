//
//  PresentTableViewCell.h
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentMdoel.h"

@protocol PresentTableViewCellDelegate <NSObject>

- (void)deleteCollect;

@end

@interface PresentTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cover_image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *likes_count;
@property (nonatomic, strong) UIImageView *backGroud;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, strong) UIImageView *heartImage;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) id<PresentTableViewCellDelegate> presentTVCDelegate;
@end
