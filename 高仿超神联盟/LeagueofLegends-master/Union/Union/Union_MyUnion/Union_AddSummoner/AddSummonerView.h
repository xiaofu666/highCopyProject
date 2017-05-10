//
//  AddSummonerView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/18.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddSummonerBlock)();

@interface AddSummonerView : UIView

@property (nonatomic , copy ) AddSummonerBlock addSummonerBlock;//添加召唤师回调block

@end
