//
//  PreorderNoteCell.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/11/01.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>

@protocol PreorderNoteCellDelegate <NSObject>

- (void)doNoteFinished:(NSString *)note;

@end


@interface PreorderNoteCell : UITableViewCell

@property (nonatomic, weak) id<PreorderNoteCellDelegate> delegate;

+ (CGFloat)height;

- (void)closeKeyboard;

@end
