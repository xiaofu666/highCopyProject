//
//  config__api.h
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/13.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#ifndef config__api_h
#define config__api_h


#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)


#define VIEW_WIDTH   self.view.bounds.size.width
#define VIEW_HEIGHT  self.view.bounds.size.height
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height


//首页——推荐
#define  HOME__RECOMMEND  @"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-101&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-101&count=30&essence=1&message_cursor=0&min_time=1460548187&mpic=1"

//#define kScreenBounds ([[UIScreen mainScreen] bounds])
//首页——视频
#define HOME__VIDEO @"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-104&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-104&count=30&essence=1&message_cursor="
#define HOME__VIDEO__SUB  @"&min_time=1460547064&mpic=1"
//图片
#define HOME__PICTURE @"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-103&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-103&count=30&essence=1&message_cursor=" 
#define HOME_PICTURE_SUB @"&min_time=1460548400&mpic=1"
//段子
#define HOME__TEXT @"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-102&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-102&count=30&essence=1&message_cursor=0&min_time=1460548832&mpic=1"
//发现
#define FIND__CELL @"http://lf.snssdk.com/2/essay/discovery/v3/?iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7"
//发现detail
#define FIND__DETAIL__CELL @"http://lf.snssdk.com/neihan/stream/category/data/v2/?tag=joke&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=D446AF1B-9B63-49A0-949F-13840953AE2B&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&category_id="

//@"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-101&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-101&count=30&essence=1&message_cursor=0&min_time=1459235001&mpic=1",
//@"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-104&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-104&count=30&essence=1&message_cursor=0&min_time=1459323842&mpic=1",
//@"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-103&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-103&count=30&essence=1&message_cursor=0&min_time=1459237583&mpic=1",
//@"http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-102&iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=2543AE3C-285B-4DC1-A2C1-9E56C304410F&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7&content_type=-102&count=30&essence=1&message_cursor=0&min_time=1459329539&mpic=1"

/*
 登录成功
 token=0E7038CE24E60C4A9CFD883BD55FAB29
 openId=DDA704C7C42B93D0FE06DE844820FFD2
 appid = 1103297850
 &token=0E7038CE24E60C4A9CFD883BD55FAB29&openId=DDA704C7C42B93D0FE06DE844820FFD2&appid=1103297850
 //发表言论
 http://lf.snssdk.com/2/essay/zone/ugc/post/v2/?iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=D446AF1B-9B63-49A0-949F-13840953AE2B&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7
 api_report
 http://mon.snssdk.com/monitor/settings/?iid=3976864185&os_version=9.2&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=D446AF1B-9B63-49A0-949F-13840953AE2B&vid=DB40F549-3CE1-410D-B048-7C5529F5AAF9&openudid=62b72f71f298f44575828015eedd281a5289ad23&device_type=iPhone%205S&version_code=5.0.1&ac=WIFI&screen_width=640&device_id=13100965125&aid=7
 各个url接口的列表
 http://ib.snssdk.com/neihan/service/tabs/?os_api=18
 推荐
 http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-101
 视频
 http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-104
 图片
 http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-103
 段子
 http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-102
 精华
 http://i.snssdk.com/neihan/in_app/essence_list/
 同城
 http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-201
 
 http://ib.snssdk.com/neihan/stream/mix/v1/
 同意协议??
 */
#endif /* config__api_h */
