//
//  DropArticleCache.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DropArticleCache : CCNode {
    
}
-(void) spawnArticleAt:(CGPoint)pos which:(NSInteger)which;
-(void) cleanAllDrop;
@end
