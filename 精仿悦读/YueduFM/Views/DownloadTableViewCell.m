//
//  DownloadTableViewCell.m
//  YueduFM
//
//  Created by StarNet on 9/27/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DownloadTableViewCell.h"

@implementation DownloadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    [self.playButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [self.playButton bk_addEventHandler:^(id sender) {
        [weakSelf toggleTask];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.progressView.progressTintColor =[UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)toggleTask {
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task suspend];
    } else {
        [self.task resume];
    }
    [self updateProgress];
}

- (void)updateProgress {
    if (self.task.state == NSURLSessionTaskStateRunning) {
        self.progressView.progress = (CGFloat)self.task.countOfBytesReceived/self.task.countOfBytesExpectedToReceive;
    } else {
        self.progressView.progress = 0;
    }
}

- (void)setTask:(NSURLSessionTask *)task {
    [_task bk_removeAllBlockObservers];
    _task = task;
    
    [self setModel:[task articleModel]];
    [self updateProgress];
    __weak typeof(self) weakSelf = self;
    [task bk_removeAllBlockObservers];
    [task bk_addObserverForKeyPath:@"countOfBytesReceived" task:^(id target) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progressView.progress = (CGFloat)task.countOfBytesReceived/task.countOfBytesExpectedToReceive;
        });
    }];
    
    [self.progressView bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [self.progressView bk_addEventHandler:^(id sender) {
        [weakSelf toggleTask];
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
