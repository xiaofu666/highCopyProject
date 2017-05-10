//
//  PullCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/11.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PullCollectionViewCell.h"

@implementation PullCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)confingSubViews{
    self.titles = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.contentView.bounds.size.width - 10 , self.contentView.bounds.size.height - 10)];
    self.titles.center = self.contentView.center;
    self.titles.textAlignment = NSTextAlignmentCenter;
    self.titles.font = [UIFont systemFontOfSize:15];
    self.titles.numberOfLines = 1;
    self.titles.adjustsFontSizeToFitWidth = YES;
    self.titles.minimumScaleFactor = 0.1;
    [self.contentView addSubview:self.titles];
    
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.titles.frame.size.width - 5, 0, 20, 20)];
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"deleteIcon"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton.alpha = 0.5;
    [self.contentView addSubview:self.deleteButton];
}
-(void)passCell:(NSArray *)dataArray withIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.titles.hidden = NO;
    self.titles.text = dataArray[indexPath.item];
    if (indexPath.section == 0 & indexPath.row == 0) {
        self.titles.textColor = RGB(214, 39, 48, 1);
        self.titles.layer.masksToBounds = YES;
        self.titles.layer.borderColor = [UIColor whiteColor].CGColor;
        self.titles.layer.borderWidth = 0.0;
    }
    else{
        self.titles.textColor = RGB(101, 101, 101, 1);
        self.titles.layer.masksToBounds = YES;
        self.titles.layer.cornerRadius = CGRectGetHeight(self.contentView.bounds) * 0.3;
        self.titles.layer.borderColor = RGB(211, 211, 211, 1).CGColor;
        self.titles.layer.borderWidth = 1;
    }
}
-(void)deleteAction:(UIButton *)sender{
    if ([self.deleteDelegate respondsToSelector:@selector(deleteItemWithIndexPath:)]) {
        [self.deleteDelegate deleteItemWithIndexPath:self.indexPath];
    }
}
-(void)dealloc{
    for (UIPanGestureRecognizer *pan in self.gestureRecognizers) {
        [self removeGestureRecognizer:pan];
    }
}

@end
