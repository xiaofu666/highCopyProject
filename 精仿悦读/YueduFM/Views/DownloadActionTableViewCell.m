//
//  DownloadActionTableViewCell.m
//  YueduFM
//
//  Created by StarNet on 9/27/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DownloadActionTableViewCell.h"

@implementation DownloadActionTableViewCell

- (IBAction)onDeleteButtonPressed:(id)sender {
    if ([self.model isKindOfClass:[YDSDKModel class]]) {
        [SRV(ArticleService) deleteDownloaded:self.model completion:^(BOOL successed) {
            if (successed) {
                [self.expandTableViewController deleteCellWithModel:self.model];
            }
        }];
    } else {
        [SRV(DownloadService) deleteTask:self.model];
        [self.expandTableViewController deleteCellWithModel:self.model];
    }
}

@end
