//
//  ServerNameInputPickerView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/18.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ServerNameInputPickerView.h"

#import "PCH.h"

@interface ServerNameInputPickerView ()<UIPickerViewDataSource , UIPickerViewDelegate>;

@property (nonatomic , retain ) NSArray *pickerArray;//选择器数据数组

@property (nonatomic , retain ) UIPickerView *pickerView;//选择器

//@property (nonatomic , retain ) UIButton *completeButton;//完成按钮

@end

@implementation ServerNameInputPickerView

-(void)dealloc{
    
    [_pickerArray release];
    
    [_pickerView release];
    
    [super dealloc];
    
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //设置背景颜色
        
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:245/255.0];
        
        //初始化
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _pickerView.backgroundColor = [UIColor clearColor];
        
        _pickerView.delegate = self;
        
        [self addSubview:_pickerView];
        
//        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        _completeButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 100 , 0, 100, 40);
//        
//        [_completeButton setTitleColor:MAINCOLOER forState:UIControlStateNormal];
//        
//        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
//        
//        [self addSubview:_completeButton];
        
        _pickerArray = [[NSArray alloc]initWithArray:@[@"艾欧尼亚 电信一",@"祖安 电信二",@"诺克萨斯 电信三",@"班德尔城 电信四",@"皮尔特沃夫 电信五",@"战争学院 电信六",@"巨神峰 电信七",@"雷瑟守备 电信八",@"裁决之地  电信九",@"黑色玫瑰  电信十",@"暗影岛  电信十一",@"钢铁烈阳 电信十二",@"均衡教派 电信十三",@"水晶之痕 电信十四",@"影流 电信十五",@"守望之海 电信十六",@"征服之海 电信十七",@"卡拉曼达 电信十八",@"皮城警备 电信十九",@"比尔吉沃特 网通一",@"德玛西亚 网通二",@"弗雷尔卓德 网通三",@"无畏先锋 网通四",@"恕瑞玛 网通五",@"扭曲丛林 网通六",@"巨龙之巢 网通七",@"教育网专区 教育一"]];
        
    }
    return self;
}

#pragma mark ---UIPickerViewDataSource , UIPickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;

}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [self.pickerArray count];

}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.pickerArray objectAtIndex:row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //先判断代理是否存在 并且 是否实现了方法
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedPickerValue:)]) {
        
        [self.delegate selectedPickerValue:[self.pickerArray objectAtIndex:row]];
        
    }

    
}



@end
