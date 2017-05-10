//
//  WSChatTableViewController+CoreData.m
//  QQ
//
//  Created by weida on 15/12/24.
//  Copyright © 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTableViewController+CoreData.h"
#import "WSChatTableViewController.h"
#import "WSChatModel.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatImageTableViewCell.h"
#import "WSChatVoiceTableViewCell.h"
#import "WSChatTimeTableViewCell.h"
#import "ODRefreshControl.h"

#define kMaxBachSize      (30)    //每次最多从数据库读取30条数据
#define kPageSize         (10)    //一页10条数据



@implementation WSChatTableViewController (CoreData)


#pragma mark - NSFetchedResultsController Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

-(void)scrollToBottom:(BOOL)animated
{    //让其滚动到底部
    dispatch_async(dispatch_get_main_queue(), ^
    {
        NSInteger section = [[self.fetchedResultsController sections] count];
        if (section >= 1)
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section-1];
            NSInteger row =  [sectionInfo numberOfObjects];
            if (row >= 1)
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section-1] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
            }
        }
    });
}

-(void)loadMoreMsg
{
    NSFetchRequest *fetchRequest = self.fetchedResultsController.fetchRequest;

    NSUInteger offset = fetchRequest.fetchOffset;
    NSUInteger limit;
    NSUInteger newRows;//新增了多少条数据?
    
    if (offset>=kPageSize)
    {//可以加载前10条数据
        offset -= kPageSize;
        newRows = kPageSize;
        limit  =  [self.tableView numberOfRowsInSection:0] + newRows;
    }else
    {//前面不够一页，就显示所有数据
        newRows = offset;
        offset  = 0;
        limit   = 0;
    }
    
    [fetchRequest setFetchOffset:offset];
    [fetchRequest  setFetchLimit:limit];
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error])
    {//再次执行查询请求
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else
    {
        if (newRows)
        {
            NSMutableArray *insertRows = [NSMutableArray arrayWithCapacity:newRows];
            for (NSUInteger i =0; i<newRows; i++)
            {
                [insertRows addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:insertRows withRowAnimation:UITableViewRowAnimationNone];//如何避免一闪?
            [self.tableView endUpdates];
        }else
        {
            NSLog(@"已经没有更多数据啦。");
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [_refreshControl endRefreshing];
        
        if (newRows)
        {
           [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newRows inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];   
        }
        
    });
    
}

#pragma mark - Getter Mehod

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
   
    NSEntityDescription *entity = [WSChatModel entityInManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    [fetchRequest setFetchBatchSize:kMaxBachSize];
    [fetchRequest  setFetchLimit:kPageSize];
    
    NSUInteger totalCount = [WSChatModel count];//一共多少条记录
    
    [fetchRequest  setFetchOffset:(totalCount>=kPageSize)?(totalCount-kPageSize):0];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
}


@end
