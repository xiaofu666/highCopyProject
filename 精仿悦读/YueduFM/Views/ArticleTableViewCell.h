//
//  ArticleTableViewCell.h
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property (nonatomic, strong) YDSDKArticleModelEx* model;

@property (nonatomic, retain) IBOutlet UIImageView* pictureView;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UILabel* authorLabel;
@property (nonatomic, retain) IBOutlet UILabel* speakerLabel;
@property (nonatomic, retain) IBOutlet UILabel* durationLabel;
@property (nonatomic, retain) IBOutlet TTTAttributedLabel* detailLabel;

@property (nonatomic, retain) IBOutlet RhythmView* rhythmView;

@property (nonatomic, retain) IBOutlet UIButton* playButton;
@property (nonatomic, retain) IBOutlet UIButton* moreButton;

@property (nonatomic, assign) BOOL playing;

@end
