//
//  DownloadTableViewCell.h
//  YueduFM
//
//  Created by StarNet on 9/27/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVCircularProgressView.h"
#import "ArticleTableViewCell.h"


@interface DownloadTableViewCell : ArticleTableViewCell

@property (nonatomic, strong) NSURLSessionTask* task;

@property (nonatomic, retain) IBOutlet EVCircularProgressView* progressView;


@end
