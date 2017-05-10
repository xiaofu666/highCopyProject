//
//  SleeveHtmlWebController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/11.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleeveHtmlWebController.h"

static int pageNum=0;

@interface SleeveHtmlWebController ()<UIWebViewDelegate>
{
    NSMutableArray* dataSource;
    UIWebView *_webView;
}
@end

@implementation SleeveHtmlWebController


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIBarButtonItem* liftitem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(returnView)];
        self.navigationItem.leftBarButtonItem=liftitem;
    UIBarButtonItem* rightitem=[[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:self action:@selector(lastView)];
    self.navigationItem.backBarButtonItem = liftitem;
    if (dataSource.count!=0) {
        if (pageNum<dataSource.count-1) {
            self.navigationItem.rightBarButtonItem=rightitem;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    dataSource=[[NSMutableArray alloc]init];
    NSString* filePath=[NSString stringWithFormat:@"%@/%@/menu.json",NSHomeDirectory(),self.sleeveNameID];
    ///Users/qianfeng/Desktop/1447062532/menu.json
    NSData* data=[NSData dataWithContentsOfFile:filePath];
    dataSource=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //创建webView
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+48)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    //NSLog(@"%@",self.sleeveNameID);
    NSString* htmlPath=[NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),self.sleeveNameID,dataSource[pageNum][@"file"]];
    NSURL *url = [NSURL URLWithString:htmlPath];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@ %d/%lu",dataSource[pageNum][@"title"],pageNum+1,(unsigned long)dataSource.count];
}

-(void)returnView{
    if (pageNum==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        pageNum--;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)lastView{
    pageNum++;
    SleeveHtmlWebController* sleeveHtmlWeb=[[SleeveHtmlWebController alloc]init];
    sleeveHtmlWeb.sleeveNameID=self.sleeveNameID;
    [self.navigationController pushViewController:sleeveHtmlWeb animated:YES];
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
