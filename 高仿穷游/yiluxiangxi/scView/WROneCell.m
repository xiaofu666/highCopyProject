//
//  WROneCell.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WROneCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

#define WIDTH (float)(self.view.frame.size.width)
#define HEIGHT (float)(self.view.frame.size.height)

@implementation WROneCell
{   //左图
    UILabel* _cnnameLabel1;//显示国家汉语名
    UILabel* _ennameLabel1;//显示国家英文名
    UIImageView* _shadowImageView1;//显示黑色阴影
    UILabel* _countLabel1;//显示城市个数
    UILabel* _labelLabel1;//显示城市类型
    UIImageView* _iconImageView1;//显示图片
    UIControl* _controlView1;
    //右图
    UILabel* _cnnameLabel2;//显示国家汉语名
    UILabel* _ennameLabel2;//显示国家英文名
    UIImageView* _shadowImageView2;//显示黑色阴影
    UILabel* _countLabel2;//显示城市个数
    UILabel* _labelLabel2;//显示城市类型
    UIImageView* _iconImageView2;//显示图片
    UIControl* _controlView2;
    
}
//重写初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)createSubViews{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;

    //cell1上的左视图
    _iconImageView1 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:10 andWidth:172.5 andHeight:240]];
    _iconImageView1.userInteractionEnabled = YES;
    _controlView1 = [[UIControl alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:172.5 andHeight:240]];
    _controlView1.backgroundColor = [UIColor clearColor];
//    NSLog(@"wocia");
    [_controlView1 addTarget:self action:@selector(pressCellImageView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_iconImageView1 addSubview:_controlView1];
    [self.contentView addSubview:_iconImageView1];
    //显示国家汉语名
    _cnnameLabel1 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:180 andWidth:100 andHeight:40]];
    _cnnameLabel1.textColor = [UIColor whiteColor];
    _cnnameLabel1.font = [UIFont systemFontOfSize:20];
    [_iconImageView1 addSubview:_cnnameLabel1];
   
    //显示国家英文名
    _ennameLabel1 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:220 andWidth:100 andHeight:15]];
    _ennameLabel1.textColor = [UIColor whiteColor];
    _ennameLabel1.font = [UIFont systemFontOfSize:15];
    [_iconImageView1 addSubview:_ennameLabel1];
    //显示黑色阴影
    _shadowImageView1 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:120 andY:5 andWidth:50 andHeight:50]];
    _shadowImageView1.backgroundColor = [UIColor blackColor];
    _shadowImageView1.alpha = 0.5;
//    [_iconImageView1 addSubview:_shadowImageView1];
    //显示城市个数
    _countLabel1 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:120 andY:15 andWidth:70 andHeight:30]];
    _countLabel1.font = [UIFont systemFontOfSize:25];
    _countLabel1.textColor = [UIColor whiteColor];
    _countLabel1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_countLabel1];
    //显示城市类型
    _labelLabel1 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:120 andY:45 andWidth:50 andHeight:20]];
    _labelLabel1.textColor = [UIColor whiteColor];
    _labelLabel1.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelLabel1];
    //cell1上的右视图
    _iconImageView2 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:192.5 andY:10 andWidth:172.5 andHeight:240]];
    _iconImageView2.userInteractionEnabled = YES;
    _controlView2 = [[UIControl alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:172.5 andHeight:240]];
    _controlView2.backgroundColor = [UIColor clearColor];
    [_controlView2 addTarget:self action:@selector(pressCellImageView:) forControlEvents:UIControlEventTouchUpInside];
    [_iconImageView2 addSubview:_controlView2];
    [self.contentView addSubview:_iconImageView2];
    
    _cnnameLabel2 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:180 andWidth:100 andHeight:40]];
    _cnnameLabel2.textColor = [UIColor whiteColor];
    _cnnameLabel2.font = [UIFont systemFontOfSize:20];
    [_iconImageView2 addSubview:_cnnameLabel2];
    _ennameLabel2 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:220 andWidth:100 andHeight:15]];
    _ennameLabel2.textColor = [UIColor whiteColor];
    _ennameLabel2.font = [UIFont systemFontOfSize:15];
    [_iconImageView2 addSubview:_ennameLabel2];
    _shadowImageView2 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:100 andY:5 andWidth:70 andHeight:50]];

    _shadowImageView2.backgroundColor = [UIColor blackColor];
    _shadowImageView2.alpha = 0.5;
//    [_iconImageView2 addSubview:_shadowImageView2];
    
    _countLabel2 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:300 andY:15 andWidth:70 andHeight:30]];
    _countLabel2.textColor = [UIColor whiteColor];
    _countLabel2.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:_countLabel2];
    _labelLabel2 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:300 andY:45 andWidth:50 andHeight:20]];
    _labelLabel2.font = [UIFont systemFontOfSize:15];
    _labelLabel2.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_labelLabel2];
}

-(void)showAppModel:(WRDestinationAppModel *)appModel andIndexpath:(NSIndexPath *)indexpath{
    NSArray *array = self.contentView.subviews;
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
    [self createSubViews];
    _controlView1.tag = indexpath.row + 10;
    _controlView2.tag = indexpath.row + 20;
//    NSLog(@"%ld",_controlView1.tag);
    _cnnameLabel1.text = appModel.hot_country[indexpath.row * 2][@"cnname"];
    _ennameLabel1.text = appModel.hot_country[indexpath.row * 2][@"enname"];
    _countLabel1.text = [NSString stringWithFormat:@"%d",[appModel.hot_country[indexpath.row * 2][@"count"] intValue]];
    _labelLabel1.text = appModel.hot_country[indexpath.row * 2][@"label"];
    [_iconImageView1 setImageWithURL:[NSURL URLWithString:appModel.hot_country[indexpath.row * 2][@"photo"]]];
    if ([appModel.hot_country count] == 1 && indexpath.row * 2 + 1 == 1) {
        return;
    }
    _cnnameLabel2.text = appModel.hot_country[indexpath.row * 2 + 1][@"cnname"];
    _ennameLabel2.text = appModel.hot_country[indexpath.row * 2 + 1][@"enname"];
    _countLabel2.text = [NSString stringWithFormat:@"%d",[appModel.hot_country[indexpath.row * 2 + 1][@"count"] intValue]];
    _labelLabel2.text = appModel.hot_country[indexpath.row * 2 + 1][@"label"];
    [_iconImageView2 setImageWithURL:[NSURL URLWithString:appModel.hot_country[indexpath.row * 2 + 1][@"photo"]]];
}

-(void)pressCellImageView:(id)sender{
    UIControl* control = (UIControl*)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendControl:)]) {
        [self.delegate sendControl:control];
    }else {
        NSLog(@"没有代理或未实现协议方法");
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
