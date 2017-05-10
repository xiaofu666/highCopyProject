//
//  NZCTextPicTableViewCell.m
//  presents
//
//  Created by dllo on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "NZCTextPicTableViewCell.h"

@implementation NZCTextPicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = CGRectMake(0, 0, self.width, self.height - 51);
}

- (void)setUrlStr:(NSString *)urlStr {
    if (_urlStr != urlStr) {
        _urlStr = urlStr;
    }
    [self creatWebView];
}

- (void)creatWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.bounces = NO;
    [self addSubview:self.webView];
    
    [SAPNetWorkTool getWithUrl:self.urlStr parameter:nil httpHeader:nil responseType:ResponseTypeDATA success:^(id result) {

        NSString *string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:result];
        NSArray *array = [hpple searchWithXPathQuery:@"//div"];
        for (TFHppleElement *element in array) {
            if ([element.attributes[@"class"] isEqualToString:@"td"]) {
                
                string = [string stringByReplacingOccurrencesOfString:element.raw withString:@""];
            }
            if ([element.attributes[@"class"] isEqualToString:@"wrapper download-banner"]) {
                string = [string stringByReplacingOccurrencesOfString:element.raw withString:@""];
            }
        }
        [self.webView loadHTMLString:string baseURL:url];
    } fail:^(NSError *error) {
        NSLog(@"解析失败");
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
