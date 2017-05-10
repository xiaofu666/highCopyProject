//
//  Hero_Details_Details_LikeANDHateCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_Details_LikeANDHateCell.h"

#import "Hero_Details_LikeANDHateModel.h"


@interface HeroImageView : UIImageView

@property (nonatomic , copy ) NSString *heroName;

@end

@implementation HeroImageView

-(void)dealloc{
    
    [_heroName release];
    
    [super dealloc];
}

@end


@interface Hero_Details_Details_LikeANDHateCell ()

@property (nonatomic , retain ) NSMutableArray *itemArray;//Item数组

@end

@implementation Hero_Details_Details_LikeANDHateCell

-(void)dealloc{
    
    [_itemArray release];
    
    [_dataArray release];
    
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
        
        //初始化Item数组
        
        _itemArray = [[NSMutableArray alloc]init];

    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

#pragma mark ---获取数据

-(void)setDataArray:(NSMutableArray *)dataArray{
    
    if (_dataArray != dataArray) {
        
        [_dataArray release];
        
        _dataArray = [dataArray retain];
        
        //处理数据
        
        //清空Item
        
        for (UIView *item in self.itemArray) {
            
            [item removeFromSuperview];
            
        }
        
        //清空Item数组
        
        [self.itemArray removeAllObjects];
        
        //创建Item 并赋值数据
        
        [self loadItem:dataArray];
        
    }
    
}

- (void)loadItem:(NSMutableArray *)dataArray{
    
    //循环创建Item
    
    CGFloat Y = 50;
    
    for (Hero_Details_LikeANDHateModel *model in dataArray) {
        
        //创建英雄头像图片视图
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picImageView:)];
        
        HeroImageView *picImageView = [[HeroImageView alloc]initWithFrame:CGRectMake(10, Y, 50, 50)];
        
        picImageView.heroName = model.partner;
        
        //SDWebImage异步加载英雄头像
        
        [picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroImageURL , model.partner]] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
        picImageView.userInteractionEnabled = YES;
        
        [picImageView addGestureRecognizer:tap];
        
        [self.rootView addSubview:picImageView];
        
        //创建描述Label
        
        UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 , Y, CGRectGetWidth(self.rootView.frame) - 80 , 50)];
        
        desLabel.numberOfLines = 0;
        
        desLabel.font = [UIFont systemFontOfSize:16];
        
        desLabel.text = model.des;
        
        [self.rootView addSubview:desLabel];
        
        //计算内容所需高度 并进行相应设置
        
        CGFloat desLabelHeight = [NSString getHeightWithstring:model.des Width:CGRectGetWidth(desLabel.frame) FontSize:16];
        
        //设置描述Label的frame
        
        desLabel.frame = CGRectMake(desLabel.frame.origin.x, desLabel.frame.origin.y, CGRectGetWidth(desLabel.frame), desLabelHeight);
        
        if (CGRectGetHeight(desLabel.frame) >= 50 ) {
            
            Y += CGRectGetHeight(desLabel.frame) + 10;
            
        } else {
            
            Y += 50 + 10;
            
        }
        
        [self.itemArray addObject:picImageView];
        
        [self.itemArray addObject:desLabel];
        
    }
    
    //设置cell大小
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame), Y + 30);
    
    
}


#pragma mark ---英雄头像点击事件

- (void)picImageView:(UITapGestureRecognizer *)tap{
    
    //获取点击的图片视图
    
    HeroImageView *picImageView = (HeroImageView *)tap.view;
    
    //调用跳转英雄详情Block 传递英雄英文名字
    
    self.selectedHeroToHeroDetails(picImageView.heroName);
    
}

@end
