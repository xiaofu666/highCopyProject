//
//  PlayListActionTableViewCell.m
//  YueduFM
//
//  Created by StarNet on 9/29/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "PlayListActionTableViewCell.h"

@implementation PlayListActionTableViewCell

- (IBAction)onDeleteButtonPressed:(id)sender {
    YDSDKArticleModelEx* aModel = self.model;
    aModel.preplayDate = [NSDate dateWithTimeIntervalSince1970:0];
    [SRV(DataService) writeData:aModel completion:nil];
    [self.expandTableViewController deleteCellWithModel:self.model];
}

@end
