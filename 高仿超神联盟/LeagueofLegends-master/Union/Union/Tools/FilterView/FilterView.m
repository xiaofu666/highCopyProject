//
//  FilterView.m
//  筛选栏封装
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FilterView.h"

#import "FilterMenuItem.h"

#import "FilterMenuModel.h"

#import "PCH.h"

#define kFVAlpha 0.5

@interface FilterView ()

@property (nonatomic , retain ) NSMutableArray *itemArray;//Item数组

@property (nonatomic , assign ) CGFloat originalHeigth;//本视图原有高度

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    //设置最小高度为40
    
    if (frame.size.height < 40) {
        
        frame.size.height = 40;
        
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景颜色
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        _originalHeigth = self.frame.size.height;
        
    }
    return self;
}

//获取数据源数组

- (void)setDataArray:(NSArray *)dataArray{
    
    if (_dataArray != dataArray) {
        
        [_dataArray release];
        
        _dataArray = [dataArray retain];
        
    }
    
    //初始化Item数组
    
    _itemArray = [[NSMutableArray alloc]init];
    
    //处理数据
    
    if (dataArray != nil && dataArray.count > 0 ) {
        
        //计算item所需宽度 (大于4个以上 按4个算宽度)
        
        CGFloat itemWidth = CGRectGetWidth(self.frame) / ( dataArray.count > 4 ? 4 : dataArray.count);
        
        NSInteger itemIndex = 0;
        
        for ( FilterMenuModel *fmModel in dataArray) {
            
            //创建菜单Item
            
            FilterMenuItem *fmItem = [[FilterMenuItem alloc]initWithFrame:CGRectMake( itemWidth * itemIndex , 0, itemWidth, CGRectGetHeight(self.frame))];
            
            fmItem.fmModel = fmModel;
            
            fmItem.ItemIndex = itemIndex;
            
            fmItem.selectedColor = MAINCOLOER;
            
            [self addSubview:fmItem];
            
            //存储到Item数组中
            
            [self.itemArray addObject:fmItem];
            
            itemIndex ++;
            
            
            //block回调实现
            
            __block FilterView *Self = self;
            
            fmItem.selectedItemBlock = ^(NSInteger itemIndex){
                
                BOOL itemIsSelected = NO;//item的选中状态
                
                //Item选中回调
                
                for (NSInteger i = 0; i < Self.itemArray.count ; i++) {
                    
                    //将除当前选中的Item以外的Item是否被选中设置为NO
                    
                    if (i != itemIndex) {
                        
                        FilterMenuItem *fmItem = Self.itemArray[i];
                        
                        fmItem.isSelected = NO;
                        
                    }
                    
                    //查询所以item的选中状态 以判断是否显示黑色模糊背景
                    
                    if (fmItem.isSelected) {
                        
                        itemIsSelected = YES;
                        
                    }
                    
                }
                
                //判断是否有item处于显示状态
                
                if (itemIsSelected) {
                    
                    //显示黑色背景 将视图填满下部屏幕
                    
                    Self.frame = CGRectMake(Self.frame.origin.x, Self.frame.origin.y, CGRectGetWidth(Self.frame), CGRectGetHeight([[UIScreen mainScreen] bounds]) - Self.frame.origin.y );
                    
                    [UIView animateWithDuration:0.3f animations:^{
                        
                        //设置背景颜色
                        
                        Self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kFVAlpha];
                        
                    }];
                    
                } else {
                    
                    //没有Item为选中状态
                    
                    [UIView animateWithDuration:0.3f animations:^{
                        
                        //设置背景颜色
                        
                        Self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                        
                    } completion:^(BOOL finished) {
                        
                        //显示黑色背景 将视图恢复原有高度
                        
                        Self.frame = CGRectMake(Self.frame.origin.x, Self.frame.origin.y, CGRectGetWidth(Self.frame) , self.originalHeigth);
                        
                    }];
                    
                }
                
            };
            
            fmItem.selectedButtonBlock = ^(NSString *buttonTitle , NSString *type){
                
                //Button选中回调
                
                //先判断代理是否存在 并且 是否实现了方法
                
                if (Self.delegate && [Self.delegate respondsToSelector:@selector(selectedScreeningConditions:Type:)]) {
                    
                    [Self.delegate selectedScreeningConditions:buttonTitle Type:type];
                    
                }

                
                //恢复视图
                
                [Self recoveryFilterView];
                
            };
            
        }
        
    }

}



//视图点击事件

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    //恢复视图
    
    [self recoveryFilterView];
    
}

//恢复视图

- (void)recoveryFilterView{
    
    //将所有Item的选中状态设置为NO;
    
    for (NSInteger i = 0; i < self.itemArray.count ; i++) {
        
        FilterMenuItem *fmItem = self.itemArray[i];
        
        fmItem.isSelected = NO;
        
    }
    
    //收回黑色半透明背景 恢复原样
    
    [UIView animateWithDuration:0.3f animations:^{
        
        //设置背景颜色
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        
        //显示黑色背景 将视图恢复原有高度
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame) , self.originalHeigth);
        
    }];

    
}


-(void)dealloc{
    
    [_dataArray release];
    
    for (FilterMenuItem *item in _itemArray) {
        
        [item release];
        
    }
    
    [_itemArray release];
    
    [super dealloc];
    
}

@end
