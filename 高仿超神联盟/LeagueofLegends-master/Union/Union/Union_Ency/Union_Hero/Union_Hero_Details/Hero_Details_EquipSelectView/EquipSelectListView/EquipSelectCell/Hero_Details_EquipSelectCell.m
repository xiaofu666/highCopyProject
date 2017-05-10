//
//  Hero_Details_EquipSelectCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_EquipSelectCell.h"

#import "UIView+Shadow.h"

#import <UIImageView+WebCache.h>

@interface Hero_Details_EquipSelectCell ()

@property (nonatomic , retain ) UIView *rootView;//根视图

@property (nonatomic , retain ) UIView *titleView;//标题前视图

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UILabel *authorLabel;//作者

@property (nonatomic , retain ) UILabel *combatLabel;//战斗力

@property (nonatomic , retain ) UIImageView *combatImageView;//战斗力图标

@property (nonatomic , retain ) NSMutableArray *imageViewArray;//图片数组



@end

@implementation Hero_Details_EquipSelectCell

-(void)dealloc{
    
    [_model release];
    
    [super dealloc];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetHeight(self.frame));
        
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化背景视图
        
        _rootView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame) - 20 , CGRectGetHeight(self.frame) - 20)];
        
        _rootView.backgroundColor = [UIColor whiteColor];
        
//        [_rootView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity:0.4f];
        
        [self addSubview:_rootView];
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(_rootView.frame) -  20 , 30)];
        
        _titleLabel.backgroundColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.text = @"出装标题";
        
        [_rootView addSubview:_titleLabel];
        
        //初始化前视图
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, 5, 20)];
        
        _titleView.backgroundColor = MAINCOLOER;
        
        [_rootView addSubview:_titleView];
        
        
        
        //初始化作者Label
        
        _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 ,  40 , CGRectGetWidth(_rootView.frame) - 100 , 20)];
        
        _authorLabel.textColor = [UIColor grayColor];
        
        _authorLabel.font = [UIFont systemFontOfSize:14];
        
        _authorLabel.text = @"作者";
        
        [_rootView addSubview:_authorLabel];
        
        //初始化战斗力Label
        
        _combatLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_rootView.frame) - 60 ,  40 , 60 , 20)];
        
        _combatLabel.textColor = [UIColor grayColor];
        
        _combatLabel.font = [UIFont systemFontOfSize:14];
        
        _combatLabel.textAlignment = NSTextAlignmentCenter;
        
        _combatLabel.text = @"00000";
        
        [_rootView addSubview:_combatLabel];
        
        //初始化战斗力图标
        
        _combatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_combatLabel.frame.origin.x - 20 , 43 , 14, 14)];
        
        _combatImageView.image = [[UIImage imageNamed:@"iconfont-zhandou"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _combatImageView.tintColor = [UIColor lightGrayColor];
        
        [_rootView addSubview:_combatImageView];
        
        //加载装备ImageView
        
        [self loadImageViews];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置背景视图
    
    _rootView.frame = CGRectMake(10, 10, CGRectGetWidth(self.frame) - 20 , CGRectGetHeight(self.frame) - 20);
    
//    [_rootView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity:0.4f];
    
}

- (void)loadImageViews{
    
    //初始化图片数组
    
    _imageViewArray = [[NSMutableArray alloc]init];
    
    //循环创建图片视图
    
    NSInteger count = 6;
    
    CGFloat imageViewSize = 40;
    
    CGFloat imageViewX = (CGRectGetWidth(self.rootView.frame) - (imageViewSize * count) ) / (count + 1);
    
    for (int i = 0 ; i < count ; i++ ) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX * ( i + 1 ) + imageViewSize * i , 70 , imageViewSize, imageViewSize)];
        
        imageView.image = [UIImage imageNamed:@"poluoimage_gray"];
        
        imageView.clipsToBounds = YES;
        
        imageView.layer.cornerRadius = 8.0f;
        
        [self.rootView addSubview:imageView];
        
        [self.imageViewArray addObject:imageView];
        
    }
    
}





#pragma mark ---获取数据

-(void)setModel:(EquipSelectModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
    }
    
    //添加数据
    
    _titleLabel.text = model.title;
    
    _authorLabel.text = [NSString stringWithFormat:@"%@   %@ ",model.author , model.server];
    
    _combatLabel.text = model.combat;
    
    //获取装备ID数组 循环遍历根据装备ID异步加载图片到图片视图上
    
    NSArray *equipIDArray = [model.end_cz componentsSeparatedByString:@","];
    
    for (NSInteger i = 0 ; i < equipIDArray.count ; i ++) {
        
        NSString *itemImageStr = [equipIDArray objectAtIndex:i];
        
        UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_Equip_ListImageURL , [itemImageStr integerValue]]] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
    }
    
}


@end
