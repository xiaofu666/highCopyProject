//
//  WSBuddyListTableHeaderView.h
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface WSBuddyListTableHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong)  id <NSFetchedResultsSectionInfo> sectionInfo;

@end
