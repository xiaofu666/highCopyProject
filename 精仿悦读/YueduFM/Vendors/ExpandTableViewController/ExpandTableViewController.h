//
//  TableViewController.h
//  YueduFM
//
//  Created by StarNet on 9/24/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseViewController.h"

@protocol ExpandTableViewControllerProtocol <NSObject>

- (UINib* )nibForExpandCell;
- (CGFloat)heightForExpandCell;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ExpandTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, ExpandTableViewControllerProtocol>

@property (nonatomic, retain) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* tableData;

- (void)reloadData:(NSArray*)data;

- (void)closeExpand;

- (void)deleteCellWithModel:(id)model;

@end
