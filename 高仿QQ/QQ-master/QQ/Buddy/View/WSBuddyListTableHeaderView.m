//
//  WSBuddyListTableHeaderView.m
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyListTableHeaderView.h"
#import "WSBuddyGroupModel.h"

#define kBkColorLine              ([UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1])
#define kTextColorTotalCountLable ([UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1])
#define kWidthTotalCountLable     (60)
#define kTraingTotalCountLable    (15)

static __weak UITableView *__tableView;

@interface WSBuddyListTableHeaderView ()
{
    CALayer *_line;
    
    UILabel *_totalCount;
    
    UIButton *_button;
}

@end



@implementation WSBuddyListTableHeaderView

-(UITableView *)tableView
{
    if (__tableView) {
        return __tableView;
    }
    
    for (UITableView *supView = (UITableView*)self.superview;supView;supView = (UITableView*)supView.superview)
    {
        if ([supView isKindOfClass:[UITableView class]])
        {
            __tableView = supView;
            break;
        }
    }

    return __tableView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _line = [[CALayer alloc]init];
        _line.backgroundColor = kBkColorLine.CGColor;
        [self.contentView.layer addSublayer:_line];
        
        _totalCount = [[UILabel alloc]init];
        _totalCount.backgroundColor = [UIColor clearColor];
        _totalCount.textAlignment = NSTextAlignmentRight;
        _totalCount.textColor = kTextColorTotalCountLable;
        _totalCount.font = [UIFont systemFontOfSize:10];
        [self.contentView.layer addSublayer:_totalCount.layer];
        
        _button = [[UIButton alloc]init];
        _button.backgroundColor = [UIColor clearColor];
        [_button setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];//这个Image必须是正方形,否则旋转会变形
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 50);
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.imageView.contentMode =  UIViewContentModeScaleAspectFit;
        [_button addTarget:self action:@selector(showGroup:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, 0, self.bounds.size.width, 0.6);
    _totalCount.frame = CGRectMake(self.bounds.size.width-kWidthTotalCountLable - kTraingTotalCountLable, 0,kWidthTotalCountLable, self.bounds.size.height);
    _button.frame = self.contentView.bounds;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    _button.imageView.transform = CGAffineTransformIdentity;
}


#pragma mark - 事件处理

-(void)showGroup:(UIButton *)sender
{
    NSLog(@"点击了:%@",self);
//    self.groupModel.hide = @(!self.groupModel.hide.boolValue);//反转

  //  BOOL hidden = self.groupModel.hide.boolValue;
    
    static BOOL hidden;
    hidden = !hidden;
    [UIView animateWithDuration:0.5 animations:^
    {
        if (!hidden)
        {
            _button.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }else
        {
            _button.imageView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished)
    {
        
    }];
   
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.tag-1] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)setSectionInfo:(id<NSFetchedResultsSectionInfo>)sectionInfo
{
    _sectionInfo = sectionInfo;
    
     _totalCount.text = [NSString stringWithFormat:@"1/%ld",[sectionInfo numberOfObjects]];
    
   // [_button setTitle:[NSString stringWithFormat:@"%@",self] forState:UIControlStateNormal];
    
    [_button setTitle:[sectionInfo name] forState:UIControlStateNormal];
    
}

//-(NSString *)description
//{
//   NSString *str = [super description];
//    
//    return [str substringFromIndex:27];
//}


@end
