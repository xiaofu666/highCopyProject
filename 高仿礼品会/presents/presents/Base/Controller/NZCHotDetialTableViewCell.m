//
//  NZCHotDetialTableViewCell.m
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.

//  热门页面详情TableViewCell

#import "NZCHotDetialTableViewCell.h"

@implementation NZCHotDetialTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self addSubview:self.collectionView];
        
        self.textAndPic = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.textAndPic setTitle:@"图文详情" forState:UIControlStateNormal];
        self.textAndPic.backgroundColor = [UIColor orangeColor];
        [self.textAndPic addTarget:self action:@selector(TextAndPicDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.textAndPic];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textAndPic.frame = CGRectMake(0, 0, self.width, 50);
    [self creatpicTableView];
    self.picTableView.frame = CGRectMake(0, 50, self.width, self.height - 50);
}

- (void)setUrlString:(NSString *)urlString {
    if (_urlString != urlString) {
        _urlString = urlString;
    }
}

- (void)TextAndPicDidPress:(UIButton *)sender {
    
    self.picTableView.hidden = NO;
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NZCTextPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NZCTextPicTableViewCellIdentifier"];
    cell.urlStr = self.urlString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


#pragma mark - creatpicTableView
- (void)creatpicTableView {
    self.picTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.picTableView.delegate = self;
    self.picTableView.dataSource = self;
    [self.picTableView registerClass:[NZCTextPicTableViewCell class] forCellReuseIdentifier:@"NZCTextPicTableViewCellIdentifier"];
    self.picTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self addSubview:_picTableView];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
