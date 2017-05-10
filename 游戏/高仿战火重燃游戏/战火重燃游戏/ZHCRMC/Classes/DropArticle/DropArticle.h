//
//  DropArticle.h
//  ZHCR
//
//  Created by jiangyu on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Base.h"
#import "Defines.h"

@interface DropArticle : Base {
    CGPoint startPos;
    ccTime interval;
    BOOL isdeath;
}
//-(void) move;
-(CGPoint) setPos:(CGPoint) pos;
-(void) spawnAt:(CGPoint) pos;
-(void) AddPropertyForShip;

@end

@interface BulletTypeArct : DropArticle
{
    NSArray * actionArray;
    NSInteger actionIndex;
}

@end

@interface NukeArct : DropArticle

@end

@interface PointArct : DropArticle

@end

@interface BulletLevelArct : DropArticle{
    BOOL hasChangeColor;
}

@end
