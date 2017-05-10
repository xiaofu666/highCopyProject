//
//  Hero_Details_VideoListView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_VideoListView.h"

#import "Union_Video_VideoListTableView.h"

#import "PCH.h"

#import "NSString+URL.h"

@interface Hero_Details_VideoListView ()

@property (nonatomic , retain ) Union_Video_VideoListTableView *videoListTableView;//视频列表视图

@end

@implementation Hero_Details_VideoListView

-(void)dealloc{
    
    [_videoListTableView release];
    
    [_enHeroName release];
    
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _videoListTableView = [[Union_Video_VideoListTableView alloc]initWithFrame:CGRectMake(0 , 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
        
        [self addSubview:_videoListTableView];
        
    }
   
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _videoListTableView.frame = CGRectMake(0 , 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    
}

-(void)setRootVC:(UIViewController *)rootVC{
    
    if (_rootVC != rootVC) {
        
        [_rootVC release];
        
        _rootVC = [rootVC retain];
        
    }
    
    _videoListTableView.rootVC = rootVC;
    
}

-(void)setEnHeroName:(NSString *)enHeroName{
    
    if (_enHeroName != enHeroName) {
        
        [_enHeroName release];
        
        _enHeroName = [enHeroName retain];
        
    }
    
    if (enHeroName != nil) {
        
        _videoListTableView.urlStr = [[NSString stringWithFormat:kUnion_Video_URL , @"%ld" , enHeroName] URLEncodedString];
        
    }

    
}


@end
