//
//  LXTableView.m
//  LXMenuAnimation
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LXContextMenuTableView.h"

#import "UIView+LXConstraints.h"

#import "LXContextMenuCell.h"

#import "ContextMenuCell.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

static CGFloat const defaultDuration = 0.3;

static CGPoint const defaultViewAnchorPoint =  {0.5f, 0.5f};

static NSString *const menuCellIdentifier = @"rotationCell";

typedef void(^completionBlock)(BOOL completed);

typedef NS_ENUM(NSUInteger, Direction) {

    right,
    top,
    bottom

};

typedef NS_ENUM(NSUInteger, AnimatingState) {
    
    Hiding = -1,
    Stable = 0,
    Showing = 1

};


@interface LXContextMenuTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) __block NSInteger animatingIndex;

@property (nonatomic, retain) NSMutableArray *topCells;

@property (nonatomic, retain) NSMutableArray *bottomCells;

@property (nonatomic, retain) UITableViewCell<LXContextMenuCell> *selectedCell;

@property (nonatomic, retain) NSIndexPath *dismissalIndexpath;

@property (nonatomic) AnimatingState animatingState;

@end

@implementation LXContextMenuTableView

-(void)dealloc{
    
    [_topCells release];
    
    [_bottomCells release];
    
    [_selectedCell release];
    
    [_dismissalIndexpath release];
    
    [_menuIcons release];
    
    [_menuTitles release];
    
    [super dealloc];
    
}

#pragma mark - Init

- (instancetype)initWithTableViewDelegateDataSource:(id<UITableViewDelegate, UITableViewDataSource>)delegateDataSource {
    
    self = [self init];
    
    if (self) {
    
        self.delegate = delegateDataSource;
    
        self.dataSource = delegateDataSource;
    
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
   
    if (self) {
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource = self;
    
        self.animatingState = Stable;
        
        self.animationDuration = defaultDuration;
        
        self.animatingIndex = 0;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        
        self.separatorColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:0];
    
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //表视图底部视图大小设为0
    
        //注册nib
        
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        
        [self registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
        
        
    }
  
    return self;

}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(LXContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView dismisWithIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuTitles.count;
    
}

- (UITableViewCell *)tableView:(LXContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}


#pragma mark - 显示 / 收起

- (void)showInView:(UIView *)superview withEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated {
    
    if (self.animatingState!=Stable) {
     
        return;
    
    }
    
    for (UITableViewCell<LXContextMenuCell> *aCell in [self visibleCells]) {
     
        aCell.contentView.hidden = YES;
    
    }
    
    self.dismissalIndexpath = nil;
    
    [superview addSubViewiew:self withSidesConstrainsInsets:edgeInsets];
    
    if (animated) {
     
        self.animatingState = Showing;
        
        self.alpha = 0;
        
        [self setUserInteractionEnabled:NO];
        
        [UIView animateWithDuration:self.animationDuration animations:^{
        
            self.alpha = 1;
        
        } completion:^(BOOL finished) {
        
            [self show:YES visibleCellsAnimated:YES];
            
            [self setUserInteractionEnabled:YES];
        
        }];
        
    } else {
        
        [self show:YES visibleCellsAnimated:NO];
    
    }

}

- (void)dismisWithIndexPath:(NSIndexPath *)indexPath {
    
    if (self.animatingState!=Stable) {
    
        return;
    
    }
    
    if (!indexPath) {
    
        [self removeFromSuperview];
        
        return;
    }
    
    self.dismissalIndexpath = indexPath;
    
    self.animatingState = Hiding;
    
    
    [self setUserInteractionEnabled:NO];
    
    NSArray *visibleCells = [self visibleCells];
    
    
    self.topCells = [NSMutableArray array];
    
    self.bottomCells = [NSMutableArray array];
    
    for (UITableViewCell<LXContextMenuCell> *visibleCell in visibleCells) {
       
        if ([self indexPathForCell:visibleCell].row<indexPath.row) {
        
            [self.topCells addObject: visibleCell];
        
        } else if ([self indexPathForCell:visibleCell].row>indexPath.row) {
        
            [self.bottomCells addObject: visibleCell];
        
        } else {
        
            self.selectedCell = visibleCell;
        
        }
    
    }
    
    [self dismissTopCells];
    
    [self dismissBottomCells];

}


- (void)updateAlongsideRotation {
    
    if (self.animatingState == Hiding) {
    
        if ([self.LXDelegate respondsToSelector:@selector(contextMenuTableView:didDismissWithIndexPath:)]) {
        
            [self.LXDelegate contextMenuTableView:self didDismissWithIndexPath:[self indexPathForCell:self.selectedCell]];
        
        }
        
        [self removeFromSuperview];
    
    } else if (self.animatingState == Showing) {
    
        [self show:YES visibleCellsAnimated:NO];
    
    }
    
    self.animatingState = Stable;

}

#pragma mark - Private

- (void)show:(BOOL)show visibleCellsAnimated:(BOOL)animated {
   
    NSArray *visibleCells = [self visibleCells];
    
    
    if (visibleCells.count == 0 || self.animatingIndex == visibleCells.count) {
    
        self.animatingIndex = 0;
        
        [self setUserInteractionEnabled:YES];
        
        [self reloadData];
        
        self.animatingState = Stable;
        
        return;
   
    }
    
    UITableViewCell<LXContextMenuCell> *visibleCell = [visibleCells objectAtIndex:self.animatingIndex];
   
    if (visibleCell) {
        [self prepareCellForShowAnimation:visibleCell];
    
        [visibleCell contentView].hidden = NO;
        
        Direction direction = ([visibleCells indexOfObject:visibleCell] == 0) ? right : top;
        
        
        [self show:show cell:visibleCell animated:animated direction:direction clockwise:NO completion:^(BOOL completed) {
            
            if (completed) {
        
                self.animatingIndex++;
            
                [self show:show visibleCellsAnimated:animated];
            
            }
        
        }];

    }

}

- (void)dismissBottomCells {
   
    if (self.bottomCells.count) {
    
        UITableViewCell<LXContextMenuCell> *hidingCell = [self.bottomCells lastObject];
        
        [self show:NO cell:hidingCell animated:YES direction:top clockwise:NO completion:^(BOOL completed) {
        
            if (completed) {
            
                [self.bottomCells removeLastObject];
                
                [self dismissBottomCells];
                
                [self shouldDismissSelf];
             
            }
         
        }];
    
    }

}

- (void)dismissTopCells {
    
    if (self.topCells.count) {
    
        UITableViewCell<LXContextMenuCell> *hidingCell = [self.topCells firstObject];
        
        [self show:NO cell:hidingCell animated:YES direction:bottom clockwise:YES completion:^(BOOL completed) {
        
            if (completed) {
            
                [self.topCells removeObjectAtIndex:0];
                
                
                [self dismissTopCells];
                
                [self shouldDismissSelf];
             
            }
         
        }];
   
    }

}

- (void)dismissSelf {
   
    [self show:NO cell:self.selectedCell animated:YES direction:right clockwise:NO completion:^(BOOL completed) {
    
        [self removeFromSuperview];
        
        if ([self.LXDelegate respondsToSelector:@selector(contextMenuTableView:didDismissWithIndexPath:)]) {
        
            [self.LXDelegate contextMenuTableView:self didDismissWithIndexPath:[self indexPathForCell:self.selectedCell]];
        
        }
        
        self.animatingState = Stable;
     
    }];

}

- (void)shouldDismissSelf {
   
    if (self.bottomCells.count == 0 && self.topCells.count == 0) {
    
        [self dismissSelf];
    
    }

}

#pragma mark - 动画 Cells

- (void)prepareCellForShowAnimation:(UITableViewCell<LXContextMenuCell> *)cell {
    
    [self resetAnimatedIconForCell:cell];
    
    Direction direction = ([self indexPathForCell:cell].row == 0) ? right : top;
    
    [self show:NO cell:cell animated:NO direction:direction clockwise:NO completion:nil];
}

/*!
 @abstract
 
 单元格视图隐藏或显示
 
 @param show - YES 为显示 , NO 为隐藏
 
 @param animated - Yes 或 NO 设置动画有或没有
 
 @param animation - 动画持续时间
 
 @param direction - 方向定义侧图标动画
 
 @param clockwise - 设置YES 为顺时针
 
 @param completed - block 动画完成回调Block方法
 */

- (void)show:(BOOL)show
        cell:(UITableViewCell<LXContextMenuCell> *)cell
    animated:(BOOL)animated
   direction:(Direction)direction
   clockwise:(BOOL)clockwise
  completion:(completionBlock)completed {
    
    UIView *icon = [cell animatedIcon];
    UIView *content = [cell animatedContent];
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0/200; //Add the perspective
    
    CGFloat rotation = 90;
   
    if (clockwise) {
    
        rotation = -rotation;
    
    }

    if (show) {
    
        rotation = 0;
    
    }
    
    switch (direction) {
        
        case right: {
            
            [self setAnchorPoint:CGPointMake(1, 0.5) forView:icon];
            
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, DEGREES_TO_RADIANS(rotation), 0.0f, 1.0f, 0.0f);
            
            break;
        }
        case top: {
          
            [self setAnchorPoint:CGPointMake(0.5, 0.0) forView:icon];
            
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, DEGREES_TO_RADIANS(rotation), 1.0f, 0.0f, 0.0f);
            
            break;
        }
        case bottom: {
            
            [self setAnchorPoint:CGPointMake(0.5, 1) forView:icon];
            
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, DEGREES_TO_RADIANS(rotation), 1.0f, 0.0f, 0.0f);
            
            break;
        }
            
        default:
            break;
    }
    
    if (animated) {
        
        [UIView animateWithDuration:self.animationDuration animations:^{
           
            icon.layer.transform = rotationAndPerspectiveTransform;
            
            content.alpha = show;
         
        } completion:^(BOOL finished) {
        
            if (completed) {
            
                completed(finished);
             
            }
         
        }];
        
    } else {
       
        icon.layer.transform = rotationAndPerspectiveTransform;
        
        content.alpha = show;
        
        if (completed) {
        
            completed(YES);
        
        }
    
    }

}

#pragma mark - 重写

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell<LXContextMenuCell> *cell = [super dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [self resetAnimatedIconForCell:cell];
    
    if (cell) {
    
        if (self.animatingState==Showing) {
        
            [cell contentView].hidden = YES;
       
        }else if (self.animatingState==Stable)
        
        {
        
            [cell contentView].hidden = NO;
            
            [cell animatedContent].alpha = 1;
        
        }
    
    }
    
    return cell;

}

#pragma mark - 工具方法
- (void)resetAnimatedIconForCell:(UITableViewCell<LXContextMenuCell> *) cell{
    
    UIView *icon = [cell animatedIcon];
    
    icon.layer.anchorPoint = defaultViewAnchorPoint;
    
    icon.layer.transform = CATransform3DIdentity;
    
    [icon layoutIfNeeded];

}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;

}

@end
