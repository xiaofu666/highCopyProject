//
//  XHQConstant.h
//  AutoHome
//
//  Created by qianfeng on 16/3/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#ifndef XHQConstant_h
#define XHQConstant_h
// 颜色
#import "XHQZUIXINDatabase.h"
#define getColorRGBA(_r,_g,_b,_a) [UIColor colorWithRed:_r/255.0 green:_g/255.0f blue:_b/255.0f alpha:_a]
// 保存用户的路径
#define saved_user [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/users.arc"]
//屏幕宽高
#define XHQ_SCRWIDTH  [UIScreen mainScreen].bounds.size.width
#define XHQ_SCRHEIGTH [UIScreen mainScreen].bounds.size.height

#define HEIGHTOFHEARD 100

#define MAIN @"http://mrobot.pcauto.com.cn/v2/cms/channels/1?pageNo=%ld&pageSize=20&serialIds=2143,3404&v=4.0.0"



//导购 (pingce)
#define BUY @"http://mrobot.pcauto.com.cn/v2/cms/channels/3?pageNo=%ld&pageSize=20&v=4.0.0"

//新车(wenhua)
#define NEWCAR @"http://mrobot.pcauto.com.cn/v2/cms/channels/2?pageNo=%ld&pageSize=20&v=4.0.0"

//游记(YouJI)
#define TRAVEL @"http://mrobot.pcauto.com.cn/v2/cms/channels/15?pageNo=%ld&pageSize=20&v=4.0.0"

//视频（视频可以用）
#define VIDEO @"http://mrobot.pcauto.com.cn/v2/cms/channels/13?pageNo=%ld&pageSize=20&v=4.0.0"



//图赏详情
#define PICTURE @"http://mrobot.pcauto.com.cn/v2/photo/albums?groupId=89"



//论坛B9
#define MADINGDB9  @"http://mrobot.pcauto.com.cn/v3/bbs/newForumsv45/17267?pageNo=1&pageSize=20&orderby=replyat&filter=question&needImage=true&lastQuestionCreateAt=true&timestamp=479995933.540329"
//论坛A4
#define SEARCHDDETAILFORUM @"http://mrobot.pcauto.com.cn/v3/bbs/newForums/14140?idType=forum&pageNo=1&pageSize=20&orderby=replyat"


//获取所有车型列表（搜索）
#define WEBCARS_GETALLBRANDLIST @"http://app.webcars.com.cn/default.aspx?MsgID=getAllBrandList"
//搜索SUB
#define WEBCARS_GETALLBRANDLIST_SUB @"http://mrobot.pcauto.com.cn/v3/price/models/criterionv36?v=4.3.0"



//点评(有空写下）教为复杂
#define SEARCHDDETAILCOMMENT @"http://mrobot.pcauto.com.cn/v3/price/getModelListBySerialId_v4/4313"

//优惠（有空写下）解析简单，界面元素较多
#define YOUHUI @"http://mrobot.pcauto.com.cn/v3/price/promotionList?areaId=2&pageNo=1&pageSize=20&orderBy=popularity"


//关于我们
#define WEBCARS_GETABOUT @"http://app.webcars.com.cn/default.aspx?MsgID=GetAbout"



#endif /* XHQConstant_h */
