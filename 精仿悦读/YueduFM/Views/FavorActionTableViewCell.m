//
//  FavorActionTableViewCell.m
//  YueduFM
//
//  Created by StarNet on 9/27/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "FavorActionTableViewCell.h"

@implementation FavorActionTableViewCell

- (IBAction)onFavorButtonPressed:(id)sender {
    [super onFavorButtonPressed:sender];
    [self.expandTableViewController deleteCellWithModel:self.model];
}
@end
