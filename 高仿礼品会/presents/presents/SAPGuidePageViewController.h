//
//  SAPGuidePageViewController.h
//  CarsHome
//
//  Created by dapeng on 15/12/15.
//  Copyright © 2015年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol guidePageDelegate <NSObject>
- (void)click;
@end

@interface SAPGuidePageViewController : UIViewController
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIButton *enterButton;
@property (nonatomic, assign) id<guidePageDelegate>delegate;
@property (nonatomic, retain) NSArray *backGroudNameArray;
@property (nonatomic, retain) NSArray *coverNameArray;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;
- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;
@end
