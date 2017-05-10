//
//  Union_Hero_AllHeroView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Hero_AllHeroView.h"

#import "PCH.h"

#import "FilterView.h"

#import "FilterMenuModel.h"

#import "AllHeroCollectionView.h"


#define NMUBERS @"0123456789./*-+~!@#$%^&()_+-=,./;'[]{}:<>?`"

@interface Union_Hero_AllHeroView ()<FilterViewDelegate , UITextFieldDelegate>


@property (nonatomic , retain ) FilterView *filterView;//筛选视图

@property (nonatomic , retain ) UIView *searchView;//搜索视图

@property (nonatomic , retain ) AllHeroCollectionView *allHeroCV;//全部英雄集合视图

@property (nonatomic , retain ) UITextField *searchTF;//搜索输入框

@end

@implementation Union_Hero_AllHeroView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        //初始化筛选视图
        
        [self initFilterView];
        
        //初始化搜索视图
        
        [self initSearchView];
        
        //初始化集合视图
        
        [self initAllHeroCollectionView];
        
        //将筛选视图置于最上层
        
        [self bringSubviewToFront:_filterView];
        
    }
    return self;
}

#pragma mark ---初始化筛选视图

- (void)initFilterView{
    
    FilterMenuModel *fmModel1 = [[FilterMenuModel alloc]init];
    
    fmModel1.menuTitle = @"英雄类型";
    
    fmModel1.menuDic = @{ @"default" : @[@"全部类型",@"坦克",@"刺客",@"法师",@"战士",@"射手",@"辅助", @"新手" ] };
    
    
    FilterMenuModel *fmModel2 = [[FilterMenuModel alloc]init];
    
    fmModel2.menuTitle = @"英雄位置";
    
    fmModel2.menuDic = @{ @"default" : @[@"全部",@"上单",@"中单",@"ADC",@"打野" ] };
    
    
    FilterMenuModel *fmModel3 = [[FilterMenuModel alloc]init];
    
    fmModel3.menuTitle = @"英雄价格";
    
    fmModel3.menuDic = @{ @"default" : @[@"不限"] , @"点卷" : @[ @"1000" , @"1500" ,@"2000" , @"2500" , @"3000" , @"3500" ,@"4000" , @"4500" ] , @"金币" : @[ @"450" , @"1350" , @"3150" , @"4800" ,@"6300" ,@"7800" ] };
    
    
    FilterMenuModel *fmModel4 = [[FilterMenuModel alloc]init];
    
    fmModel4.menuTitle = @"排序";
    
    fmModel4.menuDic = @{ @"default" :@[@"默认" , @"物攻" , @"法伤" , @"防御" , @"操作" ,@"金币" , @"点劵" ]};
    
    _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), 40)];
    
    _filterView.dataArray = @[ fmModel1 , fmModel2 , fmModel3 , fmModel4 ];
    
    _filterView.delegate = self;
    
    [self addSubview:_filterView];
    
    [fmModel1 release];
    
    [fmModel2 release];
    
    [fmModel3 release];
    
    [fmModel4 release];
    
}

#pragma mark ---初始化搜索视图

- (void)initSearchView{
    
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    
    _searchView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [self addSubview:_searchView];
    
    //初始化搜索输入框
    
    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, CGRectGetWidth(_searchView.frame ) - 20 , 30)];
    
    _searchTF.placeholder = @"搜索";
    
    _searchTF.textAlignment = NSTextAlignmentCenter;
    
    _searchTF.delegate = self;
    
    //设置return按键样式
    
    _searchTF.returnKeyType=UIReturnKeySearch;
    
    //设置输入框样式 (圆角矩形)
    
    _searchTF.borderStyle = UITextBorderStyleRoundedRect;
    
    //设置一个默认键盘
    _searchTF.keyboardType = UIKeyboardTypeDefault;
    
    //自适应宽度
    
    _searchTF.adjustsFontSizeToFitWidth=YES;
    
    //设置编辑已显示内容清空 (默认不清空)
    
    _searchTF.clearsOnBeginEditing = YES;
    
    //设置编辑已显示内容清空的按钮
    
    _searchTF.clearButtonMode = UITextFieldViewModeAlways;
    
    [_searchView addSubview:_searchTF];
    
}

#pragma mark ---初始化集合视图

- (void)initAllHeroCollectionView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //1.设置单元格的大小 ,itemSize
    
    flow.itemSize = CGSizeMake( ( CGRectGetWidth(self.frame) - 50 ) / 4 , ( CGRectGetWidth(self.frame) - 50 ) / 4 + 30);
    
    //2.设置最小左右间距,单元格之间
    
    flow.minimumInteritemSpacing = 10;
    
    //3.设置最小上下间距, 单元格之间
    
    flow.minimumLineSpacing = 10;
    
    //4.设置滑动方向 (UICollectionViewScrollDirectionVertical 纵向)
    
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //5.section中cell的边界范围
    
    flow.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    _allHeroCV = [[AllHeroCollectionView alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 80  ) collectionViewLayout:flow];
    
    [flow release];
    
    //英雄详情页面block回调
    
    __block Union_Hero_AllHeroView *Self = self;
    
    _allHeroCV.heroDetailBlock = ^(NSString *heroName){
        
        //调用英雄详情Block 传入英雄英文名.
        
        Self.heroDetailBlock(heroName);
        
    };
    
    [self addSubview:_allHeroCV];
    
}





#pragma mark ---UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //搜索英雄
    
    [self.allHeroCV searchHeroWithHeroName:textField.text];
    
    //清空输入框内容
    
    textField.text = @"";
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //限制文本框输入
    
    //不能多于10个字符
    
    if (_searchTF.text.length >=10) {
    
        return NO;
    
    }
    
//    //只能输入英文或中文
//    
//    NSCharacterSet * charact;
//    
//    charact = [[NSCharacterSet characterSetWithCharactersInString:NMUBERS]invertedSet];
//    
//    NSString * filtered = [[string componentsSeparatedByCharactersInSet:charact]componentsJoinedByString:@""];
//    
//    BOOL canChange = [string isEqualToString:filtered];
//    
//    if(canChange) {
//        
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入英文或中文"
//                                                        delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        
//        return NO;
//    }
    
    return YES;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark ---FilterViewDelegate

- (void)selectedScreeningConditions:(NSString *)condition Type:(NSString *)type{
    
//    NSLog(@"筛选条件 : %@ , 筛选类型 : %@ " , condition , type);
    
    [self.allHeroCV dataScreeningConditions:condition Type:type];
    
}


@end
