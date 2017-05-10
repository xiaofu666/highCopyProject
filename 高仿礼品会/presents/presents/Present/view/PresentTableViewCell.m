//
//  PresentTableViewCell.m
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PresentTableViewCell.h"

@implementation PresentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cover_image = [[UIImageView alloc] init];
        self.cover_image.layer.cornerRadius = 5;
        self.cover_image.contentMode = UIViewContentModeScaleAspectFill;
        self.cover_image.clipsToBounds = YES;
        [self addSubview:self.cover_image];
        
        self.title = [[UILabel alloc] init];
        self.backGroud = [[UIImageView alloc] init];
        self.likes_count = [[UILabel alloc] init];
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backGroud];
        [self addSubview:self.likeButton];

        [self addSubview:self.likes_count];
    }return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
    self.cover_image.frame = CGRectMake(5, 5, SCREEN_SIZE.width - 10, SCREEN_SIZE.height / 5 - 10);
    self.cover_image.contentMode = UIViewContentModeScaleAspectFill;
    self.title.frame = CGRectMake(5, SCREEN_SIZE.height / 5 - 35, SCREEN_SIZE.width - 10, 30);
    self.backGroud.frame = CGRectMake(self.width - 60, 5, 40, 50);
    self.likes_count.frame = CGRectMake(self.width - 60, 40, 40, 12);
    self.likeButton.frame = CGRectMake(self.width - 60, 5, 40, 40);
}

- (void)setPresentModel:(PresentMdoel *)presentModel {
    if (_presentModel != presentModel) {
        _presentModel = presentModel;
    }
        [self.cover_image sd_setImageWithURL:[NSURL URLWithString:presentModel.cover_image_url]];
    self.title.text = presentModel.title;
    self.title.textColor = [UIColor whiteColor];
    self.title.font = [UIFont systemFontOfSize:18];
    self.title.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.100];
    
    [self addSubview:self.title];
    self.backGroud.backgroundColor = [UIColor blackColor];
    self.backGroud.alpha = 0.5;
    
    NSString *likes = [NSString stringWithFormat:@"%@", self.presentModel.likes_count];
    self.likes_count.text = likes;
    self.likes_count.font = [UIFont systemFontOfSize:12];
    self.likes_count.textColor = [UIColor whiteColor];
    self.likes_count.textAlignment = NSTextAlignmentCenter;
   
    SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    
    NSString *tableName = @"guides";
    
    [store createTableWithName:tableName];
    NSArray *array = [store getObjectById:self.title.text fromTable:tableName];
    if (array) {
        [self.likeButton setImage:[UIImage imageNamed:@"selectedHeart"] forState:UIControlStateNormal];
    }else {
        [self.likeButton setImage:[UIImage imageNamed:@"nullHeart"] forState:UIControlStateNormal];
        
    }
    
    
}
- (void)likeButtonAction:(UIButton *)like {
    
        SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
        
        NSString *tableName = @"guides";
        
        [store createTableWithName:tableName];
        NSArray *array = [store getObjectById:self.title.text fromTable:tableName];
        if (array) {
            
            SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
            
            [store createTableWithName:@"guides"];
            
            [store deleteObjectById:self.presentModel.title fromTable:@"guides"];
            
            [self.likeButton setImage:[UIImage imageNamed:@"nullHeart"] forState:UIControlStateNormal];
            
            self.likes_count.text = [NSString stringWithFormat:@"%@", self.presentModel.likes_count];
            [self.presentTVCDelegate deleteCollect];

        
    } else {
        
        
        self.number = self.presentModel.likes_count.integerValue + 1;
        
        NSDictionary *dic = @{@"title":self.presentModel.title, @"cover_image_url":self.presentModel.cover_image_url, @"url":self.presentModel.url, @"likes_count":[NSString stringWithFormat:@"%ld",self.number]};
        [store putObject:dic withId:self.presentModel.title intoTable:tableName];

        [store close];
        
        [self.likeButton setImage:[UIImage imageNamed:@"selectedHeart"] forState:UIControlStateNormal];
        
        self.likes_count.text = [NSString stringWithFormat:@"%ld", self.number];
    }
    self.flag = !self.flag;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
