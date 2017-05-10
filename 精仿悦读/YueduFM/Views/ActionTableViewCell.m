//
//  ActionTableViewCell.m
//  YueduFM
//
//  Created by StarNet on 9/24/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ActionTableViewCell.h"
#import "YDSDKArticleModelEx.h"

@implementation ActionTableViewCell

- (void)awakeFromNib {
    __weak typeof(self) weakSelf = self;
    [self.downloadButton bk_addEventHandler:^(id sender) {
        [weakSelf onDownloadButtonPressed:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.shareButton bk_addEventHandler:^(id sender) {
        [weakSelf onShareButtonPressed:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.favorButton bk_addEventHandler:^(id sender) {
        [weakSelf onFavorButtonPressed:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.deleteButton bk_addEventHandler:^(id sender) {
        [weakSelf onDeleteButtonPressed:nil];
    } forControlEvents:UIControlEventTouchUpInside];

    [self.detailButton bk_addEventHandler:^(id sender) {
        [weakSelf onDetailButtonPressed:nil];
    } forControlEvents:UIControlEventTouchUpInside];

    [self.addButton bk_addEventHandler:^(id sender) {
        [weakSelf onAddButtonPressed:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(id)model {
    [super setModel:model];

    __weak typeof(self) weakSelf = self;
    [[self article] bk_removeAllBlockObservers];
    [[self article] bk_addObserverForKeyPath:@"isFavored" task:^(id target) {
        [weakSelf updateFavorButton];
    }];
    
    [SRV(ArticleService) update:[self article] completion:nil];
}

- (YDSDKArticleModelEx* )article {
    if ([self.model isKindOfClass:[YDSDKModel class]]) {
        return self.model;
    } else {
        return [(NSURLSessionTask* )self.model articleModel];
    }
}

- (IBAction)onDownloadButtonPressed:(id)sender {
    YDSDKArticleModelEx* aModel = [self article];
    
    void(^preprocess)(NSError* error) = ^(NSError* error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (error.code) {
                case DownloadErrorCodeAlreadyDownloading:
                    [MessageKit showWithFailedMessage:LOC(@"download_doing_prompt")];
                    break;
                case DownloadErrorCodeAlreadyDownloaded:
                    [MessageKit showWithSuccessedMessage:LOC(@"download_already_prompt")];
                    break;
                default:
                    [MessageKit showWithSuccessedMessage:LOC(@"download_add_prompt")];
                    break;
            }
        });
    };
    
    if ([SRV(SettingsService) flowProtection] && SRV(ReachabilityService).status == ReachableViaWWAN) {
        UIAlertView* alert = [UIAlertView bk_alertViewWithTitle:LOC(@"network_connect_prompt") message:LOC(@"download_wwlan_prompt")];
        [alert bk_addButtonWithTitle:LOC(@"continue") handler:^{
            [SRV(DownloadService) download:aModel protect:NO preprocess:preprocess];
        }];
        
        [alert bk_addButtonWithTitle:LOC(@"download_in_wifi") handler:^{
            [SRV(DownloadService) download:aModel protect:YES preprocess:preprocess];
        }];
        
        [alert bk_setCancelButtonWithTitle:LOC(@"cancel") handler:nil];
        
        [alert show];
    } else {
        [SRV(DownloadService) download:aModel protect:NO preprocess:preprocess];
    }
}

- (IBAction)onFavorButtonPressed:(id)sender {
    YDSDKArticleModelEx* aModel = [self article];
    aModel.isFavored = !aModel.isFavored;
    [SRV(DataService) writeData:aModel completion:nil];
}

- (IBAction)onShareButtonPressed:(id)sender {
    YDSDKArticleModelEx* aModel = [self article];
    [UIViewController showActivityWithURL:aModel.url.url completion:nil];
}

- (IBAction)onDeleteButtonPressed:(id)sender {
    
}

- (IBAction)onDetailButtonPressed:(id)sender {
    [WebViewController presentWithURL:[self article].url.url];
}

- (IBAction)onAddButtonPressed:(id)sender {
    YDSDKArticleModelEx* aModel = [self article];
    aModel.preplayDate = [NSDate date];
    [SRV(DataService) writeData:aModel completion:nil];
    [MessageKit showWithSuccessedMessage:LOC(@"playlist_add_prompt")];
}

- (void)updateFavorButton {
    dispatch_async(dispatch_get_main_queue(), ^{
        YDSDKArticleModelEx* aModel = [self article];
        [self.favorButton setTitle:aModel.isFavored?LOC(@"unfavor"):LOC(@"favor")
                          forState:UIControlStateNormal];
        
        [self.favorButton setImage:aModel.isFavored?[UIImage imageNamed:@"icon_action_favored.png"]:[UIImage imageNamed:@"icon_action_favor.png"] forState:UIControlStateNormal];
    });
}

@end
