//
//  RhythmView.m
//  YueduFM
//
//  Created by StarNet on 9/23/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "RhythmView.h"

@interface RhythmView() {
    NSMutableArray* _barArray;
    NSMutableArray* _animationArray;
    BOOL            _animating;
}

@end

#define kRhythmBarWidth 2.0f
#define kRhythmBarCount 4

@implementation RhythmView

- (UIView* )barWithPointX:(CGFloat)x height:(CGFloat)height {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x, self.height-height/2, kRhythmBarWidth, height)];
    view.backgroundColor = [UIColor whiteColor];
    view.hidden = YES;
    view.layer.cornerRadius = kRhythmBarWidth/2;
    [self addSubview:view];
    return view;
}

- (void)setupAnimationForView:(UIView* )view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    animation.duration = (self.height - view.height)/self.height;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0,0,kRhythmBarWidth,view.height)];
    animation.toValue =  [NSValue valueWithCGRect:CGRectMake(0,0,kRhythmBarWidth,self.height*2)];
    animation.byValue = [NSValue valueWithCGRect:view.bounds];
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;

    _barArray = [NSMutableArray array];
    
    CGFloat w = self.width/5;
    CGFloat x = kRhythmBarWidth/2;
    [_barArray addObject:[self barWithPointX:w-x height:self.height*0.4]];
    [_barArray addObject:[self barWithPointX:2*w-x height:self.height*0.6]];
    [_barArray addObject:[self barWithPointX:3*w-x height:self.height*0.3]];
    [_barArray addObject:[self barWithPointX:4*w-x height:self.height*0.2]];
}

- (void)awakeFromNib {
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)startAnimating {
    [self stopAnimating];
    _animating = YES;
    for (UIView* bar in _barArray) {
        [self setupAnimationForView:bar];
        bar.hidden = NO;
    }
}

- (void)stopAnimating {
    _animating = NO;
    
    for (UIView* bar in _barArray) {
        [bar.layer removeAllAnimations];
        bar.hidden = YES;
    }
}

- (BOOL)isAnimating {
    return _animating;
}
@end
