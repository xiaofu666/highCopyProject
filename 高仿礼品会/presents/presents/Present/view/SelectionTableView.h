//
//  SelectionTableView.h
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PresentTableViewCell.h"

@protocol selectionTableViewDelegate <NSObject>

- (void)selectionUrl:(NSString *)url;
- (void)selectionId:(NSString *)ids;

@end

@interface SelectionTableView : UITableViewCell

@property (nonatomic, strong) NSMutableArray *scrollImageArr;
@property (nonatomic, strong) NSMutableArray *scrollButtonArr;
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, assign) id<selectionTableViewDelegate> selecDelegate;
@property (nonatomic, strong) UIImageView *scrollImage;

@end
