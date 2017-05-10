//
//  PopViewLikeQQView.m
//  PopViewLikeQQView2
//
//  Created by LiangCe on 16/1/22.
//  Copyright © 2016年 LiangCe. All rights reserved.
//
#import "XHQZuiSaoYiSaoView.h"
@interface XHQZuiSaoYiSaoView () <UITableViewDataSource, UITableViewDelegate>
/**选中的回调*/
@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, assign) BOOL animation;
@property (nonatomic, assign) NSTimeInterval come;
@property (nonatomic, assign) NSTimeInterval go;
@end
static XHQZuiSaoYiSaoView *backgroundView;
static UITableView *tableViewQ;
static CGRect frameQ;
static CGPoint anchorPointQ;
@implementation XHQZuiSaoYiSaoView
/*
 * frame               设定tableView的位置
 * imagesArr           图片数组
 * dataSourceArr       文字信息数组
 * anchorPoint         tableView进行动画时候的锚点
 * action              通过block回调 确定菜单中 被选中的cell
 * animation           是否有动画效果
 * come                菜单出来动画的时间
 * go                  菜单收回动画的时间
 */
+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go{
  
    frameQ = frame;
    anchorPointQ = anchorPoint;
    if (backgroundView) {
        [ XHQZuiSaoYiSaoView removed];
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //背景色
    backgroundView = [[XHQZuiSaoYiSaoView  alloc] initWithFrame:window.bounds];
    backgroundView.action = action;
    backgroundView.imagesArr = imagesArr;
    backgroundView.dataSourceArr = dataourceArr;
    backgroundView.animation = animation;
    backgroundView.come = come;
    backgroundView.go = go;
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.1;
    //添加手势 点击背景能够回收菜单
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:backgroundView action:@selector(handleRemoved)];
    [backgroundView addGestureRecognizer:tap];
    [window addSubview:backgroundView];
    
    //tableView
    tableViewQ = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableViewQ.delegate = backgroundView;
    tableViewQ.dataSource = backgroundView;
    
    
    //根据锚点位置来确定position
    if (anchorPoint.x == 0 && anchorPoint.y == 0)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x, frameQ.origin.y);
    if (anchorPoint.x == 0 && anchorPoint.y == 0.5)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x, frameQ.origin.y + frameQ.size.height / 2.0);
    if (anchorPoint.x == 0 && anchorPoint.y == 1)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x, frameQ.origin.y + frameQ.size.height);
    if (anchorPoint.x == 0.5 && anchorPoint.y == 0)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y);
    if (anchorPoint.x == 0.5 && anchorPoint.y == 1)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y + frameQ.size.height);
    if (anchorPoint.x == 1 && anchorPoint.y == 0)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width, frameQ.origin.y);
    if (anchorPoint.x == 1 && anchorPoint.y == 0.5)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0);
    if (anchorPoint.x == 1 && anchorPoint.y == 1)
        tableViewQ.layer.position = CGPointMake(frameQ.origin.x+30 + frameQ.size.width, frameQ.origin.y+60 + frameQ.size.height);
    anchorPointQ=anchorPoint;
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    //根据锚点位置 绘制三角
    if (anchorPointQ.x == 0 && anchorPointQ.y == 0) {
        CGContextMoveToPoint(context, frameQ.origin.x + 12, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + 10, frameQ.origin.y - 15);
        CGContextAddLineToPoint(context, frameQ.origin.x + 30, frameQ.origin.y);
    }
    if (anchorPointQ.x == 0 && anchorPointQ.y == 0.5) {
        CGContextMoveToPoint(context, frameQ.origin.x, frameQ.origin.y  + frameQ.size.height / 2.0 - 13);
        CGContextAddLineToPoint(context, frameQ.origin.x, frameQ.origin.y + frameQ.size.height / 2.0 + 13);
        CGContextAddLineToPoint(context, frameQ.origin.x - 15, frameQ.origin.y  + frameQ.size.height / 2.0);
    }
    if (anchorPointQ.x == 0 && anchorPointQ.y == 1) {
        CGContextMoveToPoint(context, frameQ.origin.x + 12, frameQ.origin.y  + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + 30, frameQ.origin.y + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + 10, frameQ.origin.y  + frameQ.size.height + 15);
    }
    if (anchorPointQ.x == 0.5 && anchorPointQ.y == 0) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 - 13, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 + 13, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y - 15);
    }
    if (anchorPointQ.x == 0.5 && anchorPointQ.y == 1) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 - 13, frameQ.origin.y + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 + 13, frameQ.origin.y + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y + frameQ.size.height + 15);
    }
    if (anchorPointQ.x == 1 && anchorPointQ.y == 0) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width - 30, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width - 10, frameQ.origin.y - 15);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width - 12, frameQ.origin.y);
    }
    if (anchorPointQ.x == 1 && anchorPointQ.y == 0.5) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0 - 13);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0 + 13);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width + 15, frameQ.origin.y + frameQ.size.height / 2.0);
    }
    if (anchorPointQ.x == 1 && anchorPointQ.y == 1) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height - 12);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height - 30);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width + 15, frameQ.origin.y + frameQ.size.height  - 10);
    }
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    tableViewQ.layer.cornerRadius = 10;
    tableViewQ.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    if (animation) {
        [UIView animateWithDuration:come animations:^{
            tableViewQ.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    tableViewQ.layer.anchorPoint = anchorPointQ;
    
    [window addSubview:tableViewQ];
}

+ (void)removed {
    if (backgroundView.animation) {
        backgroundView.alpha = 0;
        [UIView animateWithDuration:backgroundView.go animations:^{
            tableViewQ.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            backgroundView = nil;
            [tableViewQ removeFromSuperview];
            tableViewQ = nil;
        }];
    }
}
- (void)handleRemoved {
    if (backgroundView) {
        [XHQZuiSaoYiSaoView removed];
    }
}
#pragma mark ---- UITableViewDelegateAndDatasource --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifile = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        //选择普通的tableviewCell 左边是图片 右边是文字
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifile];
    }
    cell.imageView.image = [UIImage imageNamed:_imagesArr[indexPath.row]];
    cell.textLabel.text = _dataSourceArr[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableViewQ.frame.size.height / _dataSourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (backgroundView.action) {
        //利用block回调 确定选中的row
        _action(indexPath.row);
        [XHQZuiSaoYiSaoView removed];
    }
}

- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    //根据锚点位置 绘制三角
    if (anchorPointQ.x == 0 && anchorPointQ.y == 0) {
        CGContextMoveToPoint(context, frameQ.origin.x + 12, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + 10, frameQ.origin.y - 15);
        CGContextAddLineToPoint(context, frameQ.origin.x + 30, frameQ.origin.y);
    }
    if (anchorPointQ.x == 0 && anchorPointQ.y == 0.5) {
        CGContextMoveToPoint(context, frameQ.origin.x, frameQ.origin.y  + frameQ.size.height / 2.0 - 13);
        CGContextAddLineToPoint(context, frameQ.origin.x, frameQ.origin.y + frameQ.size.height / 2.0 + 13);
        CGContextAddLineToPoint(context, frameQ.origin.x - 15, frameQ.origin.y  + frameQ.size.height / 2.0);
    }
    if (anchorPointQ.x == 0 && anchorPointQ.y == 1) {
        CGContextMoveToPoint(context, frameQ.origin.x + 12, frameQ.origin.y  + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + 30, frameQ.origin.y + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + 10, frameQ.origin.y  + frameQ.size.height + 15);
    }
    if (anchorPointQ.x == 0.5 && anchorPointQ.y == 0) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 - 13, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 + 13, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y - 15);
    }
    if (anchorPointQ.x == 0.5 && anchorPointQ.y == 1) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 - 13, frameQ.origin.y + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 + 13, frameQ.origin.y + frameQ.size.height);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y + frameQ.size.height + 15);
    }
    if (anchorPointQ.x == 1 && anchorPointQ.y == 0) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width - 30, frameQ.origin.y);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width - 10, frameQ.origin.y - 15);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width - 12, frameQ.origin.y);
    }
    if (anchorPointQ.x == 1 && anchorPointQ.y == 0.5) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0 - 13);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0 + 13);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width + 15, frameQ.origin.y + frameQ.size.height / 2.0);
    }
    if (anchorPointQ.x == 1 && anchorPointQ.y == 1) {
        CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height - 12);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height - 30);
        CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width + 15, frameQ.origin.y + frameQ.size.height  - 10);
    }
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com