//
//  LHDownCell.h
//  biUp
//
//  Created by snowimba on 16/1/9.
//  Copyright © 2016年 snowimba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHASIHTTPRequest;
@class LHRequestDesc;
@interface LHDownCell : UITableViewCell
@property (nonatomic,strong) LHRequestDesc *requestDesc;
@property (nonatomic,copy) void(^deleBlock)(LHRequestDesc *);
@property (nonatomic,copy) void(^palyBlock)(id,NSString*,NSString*);
@property (weak, nonatomic) IBOutlet UIButton* seleBtn;
@property (nonatomic, strong) LHASIHTTPRequest* request;
@property (nonatomic,assign) NSInteger index;
- (IBAction)seleAction:(UIButton *)sender ;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com