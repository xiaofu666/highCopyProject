//
//  CircleView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "CircleView.h"
#import <POP/POP.h>

@interface CircleView()

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , assign ) CGFloat lineWidth;//线宽度

@property (nonatomic , assign ) CGFloat radius;//半径

@property(nonatomic) CAShapeLayer *circleLayer;

@property(nonatomic) CAShapeLayer *backgroundLayer;

- (void)addCircleLayer;

- (void)animateToStrokeEnd:(CGFloat)strokeEnd;

@end

@implementation CircleView

-(void)dealloc{
    
    [_titleLabel release];
    
    [_circleLayer release];
    
    [_backgroundLayer release];
    
    [_backColor release];
    
    [_strokeColor release];
    
    [_title release];
    
    [super dealloc];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        
        NSAssert(frame.size.width == frame.size.height, @"A circle must have the same height and width.");
        
        _lineWidth = 4.f;
        
        _radius = CGRectGetWidth(self.bounds)/2 - _lineWidth/2;
        
        //添加背景
        
        [self addBackgroundLayer];
        
        //添加环形
        
        [self addCircleLayer];
        
        
    
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0 , 0 , _radius * 2 - 4, 14);
    
    self.titleLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2 , CGRectGetHeight(self.frame)/ 2);
    
}

#pragma mark - Instance Methods

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    
    if (animated) {
    
        [self animateToStrokeEnd:strokeEnd];
        
        return;
    
    }
    
    self.circleLayer.strokeEnd = strokeEnd;

}

#pragma mark - Property Setters

- (void)setStrokeColor:(UIColor *)strokeColor
{
    
    if (_strokeColor != strokeColor) {
        
        [_strokeColor release];
        
        _strokeColor = [strokeColor retain];
        
    }
    
    self.circleLayer.strokeColor = strokeColor.CGColor;

}

-(void)setBackColor:(UIColor *)backColor{
    
    if (_backColor != backColor) {
        
        [_backColor release];
        
        _backColor = [backColor retain];
        
    }
    
    self.backgroundLayer.strokeColor = backColor.CGColor;
    
}



-(void)setTitle:(NSString *)title{
    
    if (_title != title) {
        
        [_title release];
        
        _title = [title retain];
        
    }
    
    self.titleLabel.text = title;
    
}

#pragma mark - Private Instance methods

- (void)addCircleLayer
{
    
    self.circleLayer = [CAShapeLayer layer];
    
    CGRect rect = CGRectMake(_lineWidth/2, _lineWidth/2, _radius * 2, _radius * 2);
    
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                           cornerRadius:_radius].CGPath;


    self.circleLayer.strokeColor = self.tintColor.CGColor;
    
    
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.circleLayer.lineWidth = _lineWidth;
    
    self.circleLayer.lineCap = kCALineCapRound;
    
    self.circleLayer.lineJoin = kCALineJoinRound;

    
    [self.layer addSublayer:self.circleLayer];

}

- (void)addBackgroundLayer
{
    
    self.backgroundLayer = [CAShapeLayer layer];
    
    CGRect rect = CGRectMake(_lineWidth/2, _lineWidth/2, _radius * 2, _radius * 2);
    
    self.backgroundLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:_radius].CGPath;
    
    
    self.backgroundLayer.strokeColor = self.tintColor.CGColor;
    
    
    self.backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.backgroundLayer.lineWidth = _lineWidth;
    
    self.backgroundLayer.lineCap = kCALineCapRound;
    
    self.backgroundLayer.lineJoin = kCALineJoinRound;
    
    
    [self.layer addSublayer:self.backgroundLayer];
    
}


- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    
    strokeAnimation.toValue = @(strokeEnd);
    
    strokeAnimation.springBounciness = 12.f;
    
    strokeAnimation.removedOnCompletion = NO;
    
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];

}

#pragma mark ---LazyLoading

-(UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:12];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.backgroundColor = [UIColor clearColor];
    
        [self addSubview:_titleLabel];
        
    }
    
    return _titleLabel;
    
}

@end
