//
//  TableViewController.m
//  YueduFM
//
//  Created by StarNet on 9/24/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ExpandTableViewController.h"
#import "ExpandTableViewCell.h"
#import "ExpandObject.h"

static NSString* const kExpandCellIdentifier = @"kExpandCellIdentifier";

@interface ExpandTableViewController ()

@property (nonatomic, strong) NSIndexPath* openedIndexPath;

@end

@implementation ExpandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([self nibForExpandCell]) {
        [self.tableView registerNib:[self nibForExpandCell] forCellReuseIdentifier:kExpandCellIdentifier];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)reloadData:(NSArray*)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableData = [NSMutableArray arrayWithArray:data];
        self.openedIndexPath = nil;
        [self.tableView reloadData];
    });
}

- (void)closeExpand {
    if (_openedIndexPath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            [self.tableData removeObjectAtIndex:_openedIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[_openedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            _openedIndexPath = nil;
        });
    }
}

- (void)deleteCellWithModel:(id)model {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self closeExpand];
        usleep(200*1000);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            NSUInteger row = [_tableData indexOfObject:model];
            if (row != NSNotFound) {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [self.tableData removeObject:model];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            
            [self.tableView endUpdates];
            _openedIndexPath = nil;
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.tableData[indexPath.row];
    if ([model isKindOfClass:[ExpandObject class]]) {
        ExpandTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kExpandCellIdentifier forIndexPath:indexPath];
        NSAssert([cell isKindOfClass:[ExpandTableViewCell class]], @"ExpandCell must be inherit from ExpandTableViewCell class");
        cell.expandTableViewController = self;
        cell.model = ((ExpandObject*)model).model;
        return cell;
    } else {
        return [self cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView beginUpdates];
    
    ExpandObject* object = [ExpandObject objectWithModel:self.tableData[indexPath.row]];
    
    if (_openedIndexPath) {
        [self.tableData removeObjectAtIndex:_openedIndexPath.row];
        [tableView deleteRowsAtIndexPaths:@[_openedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (_openedIndexPath.row == indexPath.row+1) {
            _openedIndexPath = nil;
        } else {

            NSInteger row = (_openedIndexPath.row > indexPath.row)?(indexPath.row+1):(indexPath.row);
            _openedIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
            
            [self.tableData insertObject:object atIndex:_openedIndexPath.row];
            [tableView insertRowsAtIndexPaths:@[_openedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    } else {
        _openedIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        
        [self.tableData insertObject:object atIndex:_openedIndexPath.row];
        [tableView insertRowsAtIndexPaths:@[_openedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDSDKArticleModel* model = self.tableData[indexPath.row];
    return [model isKindOfClass:[ExpandObject class]]?[self heightForExpandCell]:[self heightForRowAtIndexPath:indexPath];
}

- (UINib* )nibForExpandCell {
    return nil;
}

- (CGFloat)heightForExpandCell {
    return 0;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
@end
