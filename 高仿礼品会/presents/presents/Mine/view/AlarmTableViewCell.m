//
//  AlarmTableViewCell.m
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "AlarmTableViewCell.h"

@implementation AlarmTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.time = [[UILabel alloc] init];
        self.event = [[UILabel alloc] init];
        self.notes = [[UILabel alloc] init];
        self.date = [[UILabel alloc] init];
        [self addSubview:self.time];
        [self addSubview:self.event];
        [self addSubview:self.notes];
        [self addSubview:self.date];
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.event.frame = CGRectMake(10, 10, self.width - 120, 15);
    self.time.frame = CGRectMake(10, 25, self.width - 120, 25);
    self.date.frame = CGRectMake(self.width - 120, 10, 120, 15);
    
    
}

- (void)setAlarmModel:(AlarmModel *)alarmModel {
    if (_alarmModel != alarmModel) {
        _alarmModel = alarmModel;
    }
    NSString *times = [NSString stringWithFormat:@"提醒时间: %@", _alarmModel.time];
    self.time.text = times;
    self.date.text = _alarmModel.date;
    self.notes.text = _alarmModel.notes;
    self.event.text = _alarmModel.event;
    
    self.event.font = [UIFont systemFontOfSize:15];
    self.date.font = [UIFont systemFontOfSize:15];
    self.time.font = [UIFont systemFontOfSize:12];
    self.time.textColor = [UIColor grayColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
