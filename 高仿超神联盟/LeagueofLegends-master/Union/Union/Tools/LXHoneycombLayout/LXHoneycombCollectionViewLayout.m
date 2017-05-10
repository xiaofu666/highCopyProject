//
//  LXHoneycombCollectionViewLayout.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LXHoneycombCollectionViewLayout.h"

@interface LXHoneycombCollectionViewLayout ()

@property (nonatomic, assign) NSInteger oX;

@property (nonatomic, assign) NSInteger oY;

@end

@implementation LXHoneycombCollectionViewLayout


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化 设置默认属性
        
        _col = 4;
        
        _size = 40;
        
        _margin = 1;
        
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    return NO;
    
}



-(void)prepareLayout{
    
    [super prepareLayout];
    
}

-(CGSize)collectionViewContentSize
{
    
    CGFloat height = (self.size + self.margin) * ([self.collectionView numberOfItemsInSection:0] / self.col + 1);
    
    return CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), height);
    
}

#pragma mark - UICollectionViewLayout

///  为每一个Item生成布局特性

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    UICollectionView *collection = self.collectionView;
    
    CGFloat x = (self.size + self.margin) * (indexPath.item % self.col + 0.6) * 0.75;
    
    CGFloat y = (self.size + self.margin) * (indexPath.item / self.col + 0.6) * cos(M_PI * 30.0f / 180.0f);
    
    if (indexPath.item % 2 == 1) {
        
        y += (self.size + self.margin) * 0.5 * cosf(M_PI * 30.0f / 180.0f);
        
    }
    
    x += self.oX;
    
    y += self.oY;
    
    attributes.center = CGPointMake(x + collection.contentOffset.x, y + collection.contentOffset.y);
    
    attributes.size = CGSizeMake(self.size, self.size * cos(M_PI * 30.0f / 180.0f));
    
    return attributes;
    
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    if ([arr count] > 0) {
        
        return arr;
    }
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSInteger i = 0 ; i < [self.collectionView numberOfItemsInSection:0 ]; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        
    }
    
    return attributes;
}




@end
