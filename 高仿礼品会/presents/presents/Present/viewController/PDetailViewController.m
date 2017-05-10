//
//  PDetailViewController.m
//  presents
//
//  Created by dapeng on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PDetailViewController.h"
#import "UMSocial.h"
@interface PDetailViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"攻略详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareICon"] style:UIBarButtonItemStyleDone target:self action:@selector(shareAction:)];
    [self createWebView];

}

- (void)shareAction:(UIBarButtonItem *)share {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"569ce6ff67e58e0159000cf7"
                                      shareText:self.url
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                       delegate:nil];
}

- (void)createWebView {

    NSURL *url = [NSURL URLWithString:self.url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

    UIImageView *cover_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, -SCREEN_SIZE.height / 4)];
    [cover_image sd_setImageWithURL:[NSURL URLWithString:self.cover_image_url]];
//    [views addSubview:title];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
   [webView loadRequest:request];
    
    [SAPNetWorkTool getWithUrl:self.url parameter:nil httpHeader:nil responseType:ResponseTypeDATA success:^(id result) {
        NSString *string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:result];
        NSArray *array = [hpple searchWithXPathQuery:@"//head"];
        for (TFHppleElement *element in array) {
            string = [string stringByReplacingOccurrencesOfString:element.raw withString:@""];
        }
        
        NSArray *arr = [hpple searchWithXPathQuery:@"//script"];
        for (TFHppleElement *element in arr) {
            string = [string stringByReplacingOccurrencesOfString:element.raw withString:@""];
        }
        
        [webView loadHTMLString:string baseURL:url];
    } fail:^(NSError *error) {
        
    }];
    
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
//    [webView.scrollView addSubview:cover_image];
//    [webView.scrollView addSubview:views];
    webView.scrollView.contentInset = UIEdgeInsetsMake(-61, 0, 0, 0);
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
}
- (void)leftButton:(UIBarButtonItem *)left {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
