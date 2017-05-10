//
//  GearPowered.m
//  
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GearPowered.h"

#import <AudioToolbox/AudioToolbox.h>

#import <AFNetworking.h>

#import "GPLoadingView.h"

#import "GPBottomLoadingView.h"

#import "PCH.h"

@interface GearPowered ()

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic , assign) BOOL isLoading;//是否处于刷新状态

@property (nonatomic , assign) BOOL isLoadingVerification;//是否加载中验证

@property (nonatomic , retain) GPLoadingView *GPLView;//加载视图

@property (nonatomic , retain) GPBottomLoadingView *GPBLView;//底部加载视图

@property (nonatomic , assign) CGFloat height;//高度

@property (nonatomic , assign) NSInteger TopOrDown;//上拉或下拉 (0为上拉 1为下拉)



@end

@implementation GearPowered

- (void)dealloc{
    
    [_GPLView release];
    
    [_scrollView release];
    
    [_url release];
    
    [_manager release];
    
    [super dealloc];
    
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        //初始化加载视图
        
        _GPLView = [[GPLoadingView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 0)];
        
        _GPLView.isAuxiliaryGear = NO;//默认为NO
        
        //初始化底部加载视图
        
        _GPBLView = [[GPBottomLoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 0)];
        
 
    }
    
    return self;
    
}

//获取滑动视图

-(void)setScrollView:(UIScrollView *)scrollView{
    
    if (_scrollView != scrollView) {
    
        [_scrollView release];
        
        _scrollView = [scrollView retain];
    }
    
    //设置滑动视图的背景颜色为透明
    
//    scrollView.backgroundColor = [UIColor clearColor];
    
    //将更新视图添加到滑动视图后面
    
    [scrollView addSubview:self.GPLView];
    
    
    //将底部更新视图添加到滑动视图后面
    
    [scrollView addSubview:self.GPBLView];
    
    
    //默认为未刷新状态
    
    _isLoading = NO;
    
}

- (void)setIsAuxiliaryGear:(BOOL)isAuxiliaryGear{
    
    if (_isAuxiliaryGear != isAuxiliaryGear) {
    
        _isAuxiliaryGear = isAuxiliaryGear;
        
    }
    
    self.GPLView.isAuxiliaryGear = isAuxiliaryGear;
    
}

-(void)setBottomUrl:(NSURL *)bottomUrl{
    
    if (_bottomUrl != bottomUrl) {
        
        [_bottomUrl release];
        
        _bottomUrl = [bottomUrl retain];
        
    }

}


#pragma mark ---正在滑动

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    //获取内容的高度：
    
    //    如果内容高度大于UITableView高度，就取TableView高度
    
    //    如果内容高度小于UITableView高度，就取内容的实际高度
    
    self.height = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.frame.size.height : scrollView.contentSize.height;
    
    //获取底部加载视图高度
    
    CGFloat GPBLViewHeight =  scrollView.contentOffset.y + self.height - scrollView.contentSize.height;
    
    
    // 假设偏移表格高度的20%进行下拉刷新
    
    // 假设偏移表格高度的15%进行上拉刷新
    
    if (_isLoading == NO) { // 判断是否处于刷新状态，刷新中就不执行

        
        //判断是否为下拉操作
        
        if ( -scrollView.contentOffset.y > CGRectGetHeight(_GPLView.frame)) {
            
            //即将加载视图方法
            
            [self.GPLView willLoadView];

            //偏移表格高度的20%进行下拉刷新
            
            if (-scrollView.contentOffset.y / scrollView.frame.size.height > 0.2) {
                
                _TopOrDown = 1;
                
                // 调用下拉刷新方法
                
                //NSLog(@"调用下拉刷新方法");
                
                //设置刷新状态
                
                _isLoading = YES;
                
            }
            
            
        }
        
        //判断是否为上拉操作
        
        if ( GPBLViewHeight > CGRectGetHeight(_GPBLView.frame)) {
            
            //底部刷新请求url不为空时允许上拉刷新
            
            if (self.bottomUrl != nil) {
                
                //即将加载视图方法
                
                [self.GPBLView willLoadView];
                
            }
            
            //偏移表格高度的15%进行上拉刷新
            
            if ((self.height - scrollView.contentSize.height + scrollView.contentOffset.y) / self.height > 0.15) {
                
                //底部刷新请求url不为空时允许上拉刷新
                
                if (self.bottomUrl != nil) {
                    
                    _TopOrDown = 0;
                    
                    // 调用上拉刷新方法
                    
                    //NSLog(@"调用上拉刷新方法");
                    
                    //设置刷新状态
                    
                    _isLoading = YES;
                    
                }
                
            }
            
        }
        
        
    } else {
        
        
        
    }
    
    //设置加载视图大小
    
    _GPLView.frame = CGRectMake(scrollView.frame.origin.x ,  scrollView.contentOffset.y , CGRectGetWidth(scrollView.frame) , scrollView.contentOffset.y < 0 ? - scrollView.contentOffset.y : 0 );
   
    
    //底部刷新请求url不为空时允许上拉刷新
    
    if (self.bottomUrl != nil) {
        
        //设置底部加载视图大小
        
        _GPBLView.frame = CGRectMake(scrollView.frame.origin.x , scrollView.contentSize.height  , CGRectGetWidth(scrollView.frame) , GPBLViewHeight > 0 ? GPBLViewHeight : 0 );
        
    }
    

    
    
}

#pragma mark ---滑动停止时

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (decelerate) {
        

        
    }else{
        

        
    }
    
    //判断是否进入了更新状态 并设置相应处理
    
    if (_isLoading) {
        
        //加载中验证 (防止加载时出现二次加载) 为NO 说明未处于加载中
        
        if (_isLoadingVerification == NO) {
            
            _isLoadingVerification = YES;//设置加载中验证状态
            
            switch (_TopOrDown) {
                    
                case 0:
                    
                    //通过代理获取底部刷新请求Url
                    
                    //先判断代理是否存在 并且 是否实现了方法
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(settingBottomLoadDataURL)]) {
                        
                        self.bottomUrl = [self.delegate settingBottomLoadDataURL];
                        
                    }
                    
                    //底部刷新请求url不为空时允许上拉刷新
                    
                    if (self.bottomUrl != nil) {
                        
                        //上拉刷新
                        
                        //滑动视图底部加载中样式
                        
                        [self scrollViewBottomLoadingStyle: scrollView.frame.size.height - self.height ];
                        
                        //加载中视图效果
                        
                        [self.GPBLView loadingView];
                        
                        //执行数据请求方法
                        
                        [self loadingData:_bottomUrl];
                        
                    }
                    
                    break;
                    
                case 1:
                    
                    //下拉刷新
                    
                    //滑动视图加载中样式
                    
                    [self scrollViewLoadingStyle];
                    
                    //加载中视图效果
                    
                    [self.GPLView loadingView];
                    
                    //执行数据请求方法
                    
                    [self loadingData:_url];
                    
                    break;
                    
                default:
                    break;
            }

            
        }
        
    }

    
    

    
}

//滑动视图加载中样式

-(void)scrollViewLoadingStyle{
    
    self.scrollView.contentInset = UIEdgeInsetsMake( 100 , 0 , 0 , 0 );
    
}

//滑动视图加载结束样式

-(void)scrollViewDidLoadStyle{
    
    self.scrollView.contentInset = UIEdgeInsetsMake( 0 , 0 , 0 , 0 );
    
    _isLoadingVerification = NO;//设置加载验证状态
    
}

//滑动视图底部加载中样式

-(void)scrollViewBottomLoadingStyle:(CGFloat)contenHeight{
    
    self.scrollView.contentInset = UIEdgeInsetsMake(  0 , 0 , contenHeight + 60 , 0 );
    
}

//滑动视图底部加载结束样式

-(void)scrollViewDidBottomLoadStyle{

    self.scrollView.contentInset = UIEdgeInsetsMake( 0 , 0 , 0 , 0 );
    
    _isLoadingVerification = NO;//设置加载验证状态
    
}


//加载请求数据

- (void)loadingData:(NSURL *)url{
    
    if (_url != nil) {
        
        //GET异步请求
        
        __block GearPowered *Self = self;
        
        //取消之前的请求
        
        [self.manager.operationQueue cancelAllOperations];
        
        //执行新的请求操作
        
        [self.manager GET:[url absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (responseObject != nil) {
                
                //延迟1秒钟 防止动画冲突
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    
                    switch (Self.TopOrDown) {
                            
                        case 0:
                            
                            //上拉刷新
                            
                            //调用底部加载完成视图效果
                            
                            [Self.GPBLView didLoadView];
                            
                            //延迟一秒 等待结束动画后在传递数据
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                //先判断代理是否存在 并且 是否实现了方法
                                
                                if (Self.delegate && [Self.delegate respondsToSelector:@selector(didBottomLoadData:)]) {
                                    
                                    [Self.delegate didBottomLoadData:responseObject];
                                    
                                }
                                
                                
                            });
                            
                            
                            break;
                            
                        case 1:
                            
                            //下拉刷新
                            
                            //先判断代理是否存在 并且 是否实现了方法
                            
                            if (Self.delegate && [Self.delegate respondsToSelector:@selector(didLoadData:)]) {
                                
                                [Self.delegate didLoadData:responseObject];
                                
                            }
                            
                            //调用加载完成视图效果
                            
                            [Self.GPLView didLoadView];
 
                            
                            break;
                            
                        default:
                            
                            NSLog(@"未知状态");
                            
                            break;
                    }
                    
                    
                    
                });

                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            //延迟1秒钟 防止动画冲突
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                switch (Self.TopOrDown) {
                        
                    case 0:
                        
                        //上拉刷新
                        
                        
                        //调用系统震动 (必须引入 AudioToolbox.framework框架)
                        
                        AudioServicesPlaySystemSound ( kSystemSoundID_Vibrate) ;
                        
                        //调用底部错误加载视图效果
                        
                        [Self.GPBLView errorLoadView];
                        
                        break;
                        
                    case 1:
                        
                        //下拉刷新
                        
                        //调用系统震动 (必须引入 AudioToolbox.framework框架)
                        
                        AudioServicesPlaySystemSound ( kSystemSoundID_Vibrate) ;
                        
                        //调用底部错误加载视图效果
                        
                        [Self.GPLView errorLoadView];
                        
                        //提示加载失败
                        
                        [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
                        
                        
                        break;
                        
                    default:
                        
                        break;
                }
                
                
            });
            
        }];
        
        //下拉刷新完成加载动画结束Block回调
        
        _GPLView.didLoadBlock = ^(){
            
            //滑动视图加载结束样式
            
            [Self scrollViewDidLoadStyle];
            
            //设置加载状态
            
            Self.isLoading = NO;
            
            
        };
        
        //上拉刷新完成加载动画结束Block回调
        
        Self.GPBLView.didBottomLoadBlock = ^(){
            
            //滑动视图底部加载结束样式
            
            [Self scrollViewDidBottomLoadStyle];
            
            //设置加载状态
            
            Self.isLoading = NO;
            
        };
        
    }
    
}


#pragma mark ---停止加载

-(void)stopLoading{
    
    //取消之前的请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    switch (_TopOrDown) {
            
        case 0:
            
            //上拉刷新
            
            //调用底部加载完成视图效果
            
            [self.GPBLView didLoadView];
            
            break;
            
        case 1:
            
            //下拉刷新
            
            //调用加载完成视图效果
            
            [self.GPLView didLoadView];
            
            break;
            
        default:
            
            NSLog(@"未知状态");
            
            break;
    }
    
}


#pragma mark ---LazyLoading

-(AFHTTPRequestOperationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[AFHTTPRequestOperationManager manager] retain];
        
        // 设置超时时间
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer.timeoutInterval = 15.0f;
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        
    }
    
    return _manager;
    
}

@end
