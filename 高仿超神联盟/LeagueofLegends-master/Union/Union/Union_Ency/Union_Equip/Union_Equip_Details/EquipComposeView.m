//
//  EquipComposeView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/5.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipComposeView.h"

#import "PCH.h"

#import <UIImageView+WebCache.h>

#import "UIView+Shadow.h"


@interface EquipComposeView ()

@property (nonatomic , retain ) NSMutableArray *imageArray;//装备图片数组

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UIScrollView *scrollView;//滑动视图

@end

@implementation EquipComposeView

-(void)dealloc{
    
    [_equipIDArray release];
    
    [_imageArray release];
    
    [_title release];
    
    [_titleLabel release];
    
    [_scrollView release];
    
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化
        
        _imageArray = [[NSMutableArray alloc]init];
        
        //添加阴影
        
        [self dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity: 0.6f];
        
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    
    if (_title != title) {
        
        [_title release];
        
        _title = [title retain];
        
    }
    
    //设置标题
    
    self.titleLabel.text = title;
    
}

-(void)setEquipIDArray:(NSArray *)equipIDArray{
    
    if (_equipIDArray != equipIDArray) {
        
        [_equipIDArray release];
        
        _equipIDArray = [equipIDArray retain];
        
    }
    
    if (equipIDArray != nil) {
        
        //清除所有视图
        
        for (UIImageView *imageView in [self.scrollView subviews]) {
            
            [imageView removeFromSuperview];
            
        }
        
        //清空图片视图数组
        
        [self.imageArray removeAllObjects];
        
        //加载装备图片
        
        [self loadImageViews];
        
    }
    
}

//加载装备图片

- (void)loadImageViews{
    
    
    
    //循环遍历装备ID数组 根据装备ID创建装备图片并加载图片
    
    CGFloat x = 10;
    
    CGFloat y = 0;
    
    CGFloat margin = 10;
    
    CGFloat size = 45;
    
    NSInteger index = 0;
    
    for (NSString *eid in self.equipIDArray) {
        
        if (![eid isEqualToString:@""]) {
            
            //创建图片视图
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageViewAction:)];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, size, size)];
            
            imageView.userInteractionEnabled = YES;
            
            imageView.layer.cornerRadius = 8;
            
            imageView.clipsToBounds = YES;
            
            [imageView addGestureRecognizer:tap];
            
            [self.scrollView addSubview:imageView];
            
            [self.imageArray addObject:imageView];
            
            
            //拼接装备图片url
            
            NSString *picURL = [NSString stringWithFormat:kUnion_Equip_ListImageURL , (long)[eid integerValue]];
            
            //SDWebImage 异步请求加载装备图片 <根据装备ID为参数>
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
            
            
            x += size + margin;
            
            index ++;
   
        }
        
        self.scrollView.contentSize = CGSizeMake(x, 45);
        
    }
    
    
}

#pragma mark ---图片视图点击

- (void)tapImageViewAction:(UITapGestureRecognizer *)tap{
    
    //获取点击图片视图在数组中的下标
    
    NSInteger index = [self.imageArray indexOfObject:tap.view];
    
    //调用Block传递装备ID
    
    NSInteger eid = [[self.equipIDArray objectAtIndex:index] integerValue];
    
    self.selectedImageViewBlock(eid);
    
    
}

- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 15 , 5, 20)];
        
        titleView.backgroundColor = MAINCOLOER;
        
        [self addSubview:titleView];
        
        //初始化
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10 , 100, 30)];
        
        _titleLabel.textColor = [UIColor grayColor];
        
        _titleLabel.backgroundColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.text = self.title;

        [self addSubview:_titleLabel];
        
        [self bringSubviewToFront:_titleLabel];
        
    }
    
    return _titleLabel;
}

-(UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.frame), 50)];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
    }
    
    return _scrollView;
    
}

@end
