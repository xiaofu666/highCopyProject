//
//  Hero_Details_RankingListView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_RankingListView.h"

#import "PCH.h"

@interface Hero_Details_RankingListView ()

@property (nonatomic , retain ) NSURL *url;

@end

@implementation Hero_Details_RankingListView

-(void)dealloc{
    
    [_url release];
    
    [_enHeroName release];
    
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //设置代理
        
        self.delegate = self;
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    
}

-(void)setEnHeroName:(NSString *)enHeroName{
    
    if (_enHeroName != enHeroName) {
        
        [_enHeroName release];
        
        _enHeroName = [enHeroName retain];
        
    }
    
    if (enHeroName != nil) {
        
        //加载内容
        
        _url = [NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroDetails_RankingURL , enHeroName]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:_url];
        
        [self loadRequest:request];
        
    }
    
}

#pragma mark ---UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL isEqual: _url]) {
        
        return YES;
        
    } else {
        
        return NO;
    }
    
}







@end
