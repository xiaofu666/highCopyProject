//
//  FilterMenuItem.m
//  筛选栏封装
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FilterMenuItem.h"

@interface FilterMenuItem ()

@property (nonatomic , assign ) CGFloat originalX;//本视图原有X

@property (nonatomic , assign ) CGFloat originalWidth;//本视图原有宽度

@property (nonatomic , assign ) CGFloat originalHeigth;//本视图原有高度

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UIImageView *markImageView;//标记图片

@property (nonatomic , retain ) UIView *contentView;//菜单内容视图

@property (nonatomic , retain ) NSMutableArray *buttonArray;//按钮数组

@property (nonatomic , assign ) CGFloat contentViewHeight;//内容视图高度

@property (nonatomic , assign ) CGFloat buttonX;

@property (nonatomic , assign ) CGFloat buttonY;

@end

@implementation FilterMenuItem


//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //记录原有值
    
        _originalX = self.frame.origin.x;
        
        _originalWidth = self.frame.size.width;
        
        _originalHeigth = self.frame.size.height;
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0 , CGRectGetWidth(self.frame) - 10 , CGRectGetHeight(self.frame))];
        
        _titleLabel.textColor = [UIColor grayColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:_titleLabel];
    
        
        //初始化菜单内容视图
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake( 0  , CGRectGetHeight(self.frame) , CGRectGetWidth([[UIScreen mainScreen] bounds]), 0)];
        
        _contentView.backgroundColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
        _contentView.clipsToBounds = YES;
        
        [self addSubview:_contentView];
        
        //初始化button按钮
        
        _buttonArray = [[NSMutableArray alloc]init];
        
    }
    return self;
}


-(void)setFmModel:(FilterMenuModel *)fmModel{
    
    if (_fmModel != fmModel) {
        
        [_fmModel release];
        
        _fmModel = [fmModel retain];
        
    }
    
    //数据处理
    
    self.titleLabel.text = fmModel.menuTitle;
    
    //内容视图高度
    
    self.contentViewHeight = 0;
    
    //判断数组非空
    
    if (fmModel.menuDic != nil && fmModel.menuDic.count > 0) {
        
        
        //设置button默认X , Y 轴
        
        self.buttonX = 5;
        
        self.buttonY = 5;
        
        NSInteger keyID = 0;
        
        for (NSString *key in fmModel.menuDic) {
            
            
            if (![key isEqualToString:@"default"]) {
                
                //非默认分组 添加分组标题
                
                self.buttonY += 5;
                
                //判断分组key是否有值 有值创建分组标题 无值创建分隔线
                
                if ([key isEqualToString:@""]) {
                    
                    //创建分隔线
                    
                    UIView *contentGroupLineView = [[UIView alloc]initWithFrame:CGRectMake(5, self.buttonY, CGRectGetWidth(self.contentView.frame) - 10 , 0.5 )];
                    
                    contentGroupLineView.backgroundColor = [UIColor lightGrayColor];
                    
                    [self.contentView addSubview:contentGroupLineView];
                    
                    [contentGroupLineView release];
                    
                } else {
                    
                    //创建分组标题
                    
                    UILabel *contentGroupTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, self.buttonY, CGRectGetWidth(self.contentView.frame) - 10 , 10)];
                    
                    contentGroupTitle.textColor = [UIColor grayColor];
                    
                    contentGroupTitle.font = [UIFont systemFontOfSize:10];
                    
                    contentGroupTitle.text = [NSString stringWithFormat:@"%@:",key];
                    
                    [self.contentView addSubview:contentGroupTitle];
                    
                    [contentGroupTitle release];

                    
                }
                
                
                 //设置Y轴 分组间间隔距离+25 还原X轴
                
                self.buttonY += 25;
                
                self.buttonX = 5;
                
            }
            
            
            NSArray *tempArray = [fmModel.menuDic valueForKey:key];
            
            NSInteger index = 0;
            
            for (NSString *title in tempArray) {
                
                //创建加载button到内容视图
                
                [self loadButton:title X:self.buttonX Y:self.buttonY Tag:5000 + keyID * 100 + index];
                
                index ++;
                
                //计算button x y 轴偏移
                
                self.buttonX += ( CGRectGetWidth(self.contentView.frame) - 40 ) / 4 + 10;
                
                if ( index % 4 == 0 && index < tempArray.count) {
                    
                    
                    self.buttonX = 5;
                    
                    self.buttonY += 40;
                    
                }
                
            }
            
            //循环创建该分组button结束 Y轴高度加 40 (有button创建时才加)
            
            if (tempArray.count > 0 ) {
                
                self.buttonY += 40;
            
            }
            
            keyID ++;//keyID计数+1
  
        }
        
        //为内容视图高度赋值 减去Y轴默认的高度5
        
        self.contentViewHeight = self.buttonY - 5;
        
        
    } else {
        
        self.contentViewHeight = 0;
        
    }
    
}

//加载button

- (void)loadButton:(NSString *)title X:(CGFloat)x Y:(CGFloat)y Tag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake( x , y , ( CGRectGetWidth(self.contentView.frame) - 40 ) / 4 , 30 );
    
    button.tag = tag;
    
    button.titleLabel.font = [UIFont systemFontOfSize: 11.0];
    
    button.layer.borderWidth = 0.1;
    
    button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    button.layer.cornerRadius = 3;//button圆角半径
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//默认状态时颜色
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];//选中状态时颜色
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setBackgroundColor:[UIColor whiteColor]];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:button];
    
    //将创建的button添加到按钮数组中
    
    [self.buttonArray addObject:button];
    
}

//button事件

- (void)buttonAction:(UIButton *)sender{
    
    //判断是否为第一个button(默认button)
    
    if (sender.tag == 5000) {
        
        //如果为默认button Item样式不变 label变为默认title
        
        self.titleLabel.textColor = [UIColor grayColor];
        
        self.titleLabel.text = self.fmModel.menuTitle;
        
    } else {
        
        //非默认button Item样式变为选中颜色 label变为选中button的title
        
        self.titleLabel.textColor = self.selectedColor;
        
        self.titleLabel.text = sender.titleLabel.text;
        
    }
    
   

    
    
    //处理button选中状态
    
    for (UIButton *buttonItem in self.buttonArray) {
        
        if (buttonItem != sender) {
            
            //非点击button全部设置成未选中状态
            
            buttonItem.selected = NO;
            
            //背景颜色恢复白色
            
            [buttonItem setBackgroundColor:[UIColor whiteColor]];
            
        }else{
            
            sender.selected = YES;
            
            //背景颜色为选中颜色
            
            sender.backgroundColor = self.selectedColor;
            
        }
        
    }
    
   
    
    
    //调用选中ButtonBlock 传入button的title和筛选的类型
    
    self.selectedButtonBlock(sender.titleLabel.text , self.fmModel.menuTitle);

    
}

//Item点击事件

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.isSelected) {
    
        //设置点击是否选中状态为未选择
        
        self.isSelected = NO;
        
    } else {
        
        //设置点击是否选中状态为选择
        
        self.isSelected = YES;
        
    }
    
    //调用选中ItemBlock
    
    self.selectedItemBlock(self.ItemIndex);
    
}


//Item是否被选中

-(void)setIsSelected:(BOOL)isSelected{
    
    if (_isSelected != isSelected) {
        
        _isSelected = isSelected;
        
    }
    
    //选中状态判断
    
    if (isSelected) {
        
        //设置Item背景颜色与内容视图背景颜色一致
        
        self.backgroundColor = self.contentView.backgroundColor;
        
        //选中 弹出内容视图
        
        [UIView animateWithDuration:0.25f animations:^{
            
            //设置本Item视图大小位置 (与内容视图相同 达到内容视图可以显示出来进行交互)
            
            self.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height + self.contentViewHeight);
            
            //设置内容视图高度
            
            self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width , self.contentViewHeight);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {

        
        //未选择 收回内容视图
        
        [UIView animateWithDuration:0.2f animations:^{
            
            //设置本Item视图大小位置 恢复原来大小位置
            
            self.frame = CGRectMake(self.originalX, 0, self.originalWidth , self.originalHeigth);
            
            //设置内容视图高度
            
            self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width , 0);
            
        } completion:^(BOOL finished) {
            
            //设置Item背景颜色变回原颜色
            
            self.backgroundColor = [UIColor whiteColor];
            
        }];
        
    }
    
    
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    
    if (_selectedColor != selectedColor) {
        
        [_selectedColor release];
        
        _selectedColor = [selectedColor retain];
        
    }
    
    //添加选中颜色
    
    //为默认button添加选中颜色 和选中状态
    
    UIButton *defalutButton = (UIButton *)[self.contentView viewWithTag:5000];
    
    defalutButton.backgroundColor = selectedColor;
    
    defalutButton.selected = YES;
    
    
}



-(void)dealloc{
    
    [_titleLabel release];
    
    [_contentView release];
    
    for (UIButton *button in _buttonArray) {
        
        [button release];
    }
    
    [_buttonArray release];
    
    [_selectedColor release];
    
    [_fmModel release];
    
    [super dealloc];

}


@end
