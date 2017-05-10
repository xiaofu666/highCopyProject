//
//  PlayingBackground.m
//  ZHCRCB
//
//  Created by jiangyu on 12-12-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayingBackground.h"


@implementation PlayingBackground1


-(void) update:(ccTime) delta{
    for (CCNode * node in self.backgroundArray) {
        node.position = ccpAdd(node.position, ccp(0, -1));
        if (node.position.y<=-480) {
            node.position = ccp(0, 480*2);
        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSprite * sprite1 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_01_a.png"];
        sprite1.anchorPoint = ccp(0, 0);
        sprite1.position = ccp(0, 0);
        [self addChild:sprite1];
        CCSprite * sprite2 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_01_b.png"];
        sprite2.anchorPoint = ccp(0, 0);
        sprite2.position = ccp(0, 480);
        [self addChild:sprite2];
        CCSprite * sprite3 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_01_c.png"];
        sprite3.anchorPoint = ccp(0, 0);
        sprite3.position = ccp(0, 480*2);
        [self addChild:sprite3];
        self.backgroundArray = [[[NSMutableArray alloc] initWithObjects:sprite1,sprite2,sprite3, nil]autorelease ];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
}
-(void)dealloc{
    if(self.backgroundArray){
        [self.backgroundArray removeAllObjects];
        [self.backgroundArray release];
    }
    [super dealloc];
}
@end


@implementation PlayingBackground2


-(void) update:(ccTime) delta{
    for (CCNode * node in self.backgroundArray) {
        node.position = ccpAdd(node.position, ccp(0, -1));
        if (node.position.y<=-480) {
            node.position = ccp(0, 480*2);
        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSprite * sprite1 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_02_a.png"];
        sprite1.anchorPoint = ccp(0, 0);
        sprite1.position = ccp(0, 0);
        [self addChild:sprite1];
        CCSprite * sprite2 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_02_b.png"];
        sprite2.anchorPoint = ccp(0, 0);
        sprite2.position = ccp(0, 480);
        [self addChild:sprite2];
        CCSprite * sprite3 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_02_c.png"];
        sprite3.anchorPoint = ccp(0, 0);
        sprite3.position = ccp(0, 480*2);
        [self addChild:sprite3];
        self.backgroundArray = [[[NSMutableArray alloc] initWithObjects:sprite1,sprite2,sprite3, nil]autorelease ];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
}
-(void)dealloc{
    if(self.backgroundArray){
    [self.backgroundArray removeAllObjects];
    [self.backgroundArray release];
    }
    [super dealloc];
}
@end


@implementation PlayingBackground3


-(void) update:(ccTime) delta{
    for (CCNode * node in self.backgroundArray) {
        node.position = ccpAdd(node.position, ccp(0, -1));
        if (node.position.y<=-480) {
            node.position = ccp(0, 480*2);
        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSprite * sprite1 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_03_a.png"];
        sprite1.anchorPoint = ccp(0, 0);
        sprite1.position = ccp(0, 0);
        [self addChild:sprite1];
        CCSprite * sprite2 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_03_b.png"];
        sprite2.anchorPoint = ccp(0, 0);
        sprite2.position = ccp(0, 480);
        [self addChild:sprite2];
        CCSprite * sprite3 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_03_c.png"];
        sprite3.anchorPoint = ccp(0, 0);
        sprite3.position = ccp(0, 480*2);
        [self addChild:sprite3];
        self.backgroundArray = [[[NSMutableArray alloc] initWithObjects:sprite1,sprite2,sprite3, nil]autorelease ];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
}
-(void)dealloc{
    if(self.backgroundArray){
        [self.backgroundArray removeAllObjects];
        [self.backgroundArray release];
    }
    [super dealloc];
}
@end


@implementation PlayingBackground4


-(void) update:(ccTime) delta{
    for (CCNode * node in self.backgroundArray) {
        node.position = ccpAdd(node.position, ccp(0, -1));
        if (node.position.y<=-480) {
            node.position = ccp(0, 480*2);
        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSprite * sprite1 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_04_b.png"];
        sprite1.anchorPoint = ccp(0, 0);
        sprite1.position = ccp(0, 0);
        [self addChild:sprite1];
        CCSprite * sprite2 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_04_a.png"];
        sprite2.anchorPoint = ccp(0, 0);
        sprite2.position = ccp(0, 480);
        [self addChild:sprite2];
        CCSprite * sprite3 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_04_c.png"];
        sprite3.anchorPoint = ccp(0, 0);
        sprite3.position = ccp(0, 480*2);
        [self addChild:sprite3];
        self.backgroundArray = [[[NSMutableArray alloc] initWithObjects:sprite1,sprite2,sprite3, nil]autorelease ];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
}
-(void)dealloc{
    if(self.backgroundArray){
        [self.backgroundArray removeAllObjects];
        [self.backgroundArray release];
    }
    [super dealloc];
}
@end


@implementation PlayingBackground5


-(void) update:(ccTime) delta{
    for (CCNode * node in self.backgroundArray) {
        node.position = ccpAdd(node.position, ccp(0, -1));
        if (node.position.y<=-480) {
            node.position = ccp(0, 480*2);
        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        CGSize size = [[CCDirector sharedDirector]winSize];
        CCLayerColor * colorLayer = [CCLayerColor layerWithColor:ccc4(182, 135, 82, 255) width:size.width/2 height:size.height];
        colorLayer.anchorPoint = ccp(0, 0);
        colorLayer.position = ccp(0, 0);
        [self addChild:colorLayer];
        
        CCLayerColor * colorLayer2 = [CCLayerColor layerWithColor:ccc4(210, 168, 104, 255) width:size.width/2 height:size.height];
        colorLayer2.anchorPoint = ccp(0, 0);
        colorLayer2.position = ccp(size.width/2, 0);
        [self addChild:colorLayer2];
        CCSprite * sprite1 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_05_a.png"];
        sprite1.anchorPoint = ccp(0, 0);
        sprite1.position = ccp(0, 0);
        [self addChild:sprite1];
        CCSprite * sprite2 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_05_b.png"];
        sprite2.anchorPoint = ccp(0, 0);
        sprite2.position = ccp(0, 480);
        [self addChild:sprite2];
        CCSprite * sprite3 = [CCSprite spriteWithSpriteFrameName:@"dl_scene_05_c.png"];
        sprite3.anchorPoint = ccp(0, 0);
        sprite3.position = ccp(0, 480*2);
        [self addChild:sprite3];
        self.backgroundArray = [[[NSMutableArray alloc] initWithObjects:sprite1,sprite2,sprite3, nil]autorelease ];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
}
-(void)dealloc{
    if(self.backgroundArray){
        [self.backgroundArray removeAllObjects];
        [self.backgroundArray release];
    }
    [super dealloc];
}
@end
