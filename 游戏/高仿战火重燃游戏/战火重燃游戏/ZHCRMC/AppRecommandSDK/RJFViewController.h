//
//  RJFViewController.h
//  AppRecommand
//
//  Created by jiangyu on 13-1-9.
//  Copyright (c) 2013年 jiangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITableView.h>
#import "RJFAppDownload.h"
#import "PublicDefine.h"
#include "applicationdef.h"
#import "RjfDownPicImageView.h"

@interface RJFViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,BNRDOWNAPPINFO>{
    NSMutableArray              *m_arrStoreDatasource;
    RJFAppDownload              *m_appDownload;
    UIAlertView                 *m_av;
    
    NSString                    *m_strHost;
    unsigned int                m_ifilePort;
    UITableView * tabelView;
}
@property(copy)NSString         *fileHost;
@property(readwrite) unsigned int           fileport;
@end
