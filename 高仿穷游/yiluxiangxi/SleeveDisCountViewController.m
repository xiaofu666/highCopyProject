//
//  SleeveDisCountViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleeveDisCountViewController.h"
#import "RequestModel.h"
#import "SleeveLabelCell.h"
#import "SleeveUserImageCell.h"
#import "SleeveCloseCell.h"
#import "Path.h"
#import "UIImageView+WebCache.h"
#import "SleDetailHeaderView.h"
#import "AppDelegate.h"
#import "SleeveCloseFirstCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "SSZipArchive.h"
#import "SleeveHtmlWebController.h"
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
@interface SleeveDisCountViewController () <UITableViewDataSource,UITableViewDelegate,sendRequestInfo,SleDetailHeaderViewDelegate,NSURLSessionDownloadDelegate>
{
    NSMutableDictionary* dataSource;
    UITableView* table;
    Class SleeveDisCountViewController;
    //定义NSURL对象
    NSURLSession* session;
    //创建下载任务对象
    NSURLSessionDownloadTask* task;
    //创建请求对象 NSURL
    NSURLRequest* downloadrequest;
    //定义一个NSData类型的变量 接受下载下来的数据
    NSData* data;
    NSString* downPath;
    NSString* sleeveNameID;
}

@end

@implementation SleeveDisCountViewController

-(void)checkedNet{
    //<1>创建请求操作管理者对象
    AFHTTPRequestOperationManager* manger=[AFHTTPRequestOperationManager manager];
    //<2>判断网络状态
    [manger.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"WIFI");
        }else if(status==AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"3G/4G/GPRS");
        }else if(status==AFNetworkReachabilityStatusNotReachable){
            NSLog(@"无网络连接");
        }else{
            NSLog(@"网络位置");
        }
    }];
    //<3>开启网络测试
    [manger.reachabilityManager startMonitoring];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    dataSource=[[NSMutableDictionary alloc]init];
    [self reloadDataSource];
    [self checkedNet];
}

-(void)reloadDataSource{
    RequestModel* request=[[RequestModel alloc]init];
    request.delegate=self;
    request.path=[NSString stringWithFormat:LATESTDETAIL,self.sleeveID];
    [request startRequestInfo];
}

-(void)sendMessage:(id)message andPath:(NSString *)path{
    [dataSource addEntriesFromDictionary:message[@"data"]];
    //NSLog(@"%@",dataSource);
    //SleDetailHeaderView* sleDetailHeader=[[SleDetailHeaderView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:self.view.frame.size.width andHeight:233]];
    SleDetailHeaderView* sleDetailHeader=[[SleDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 233)];
    NSString* imageStr=[NSString stringWithFormat:@"%@/670_420.jpg?cover_updatetime=%@",dataSource[@"cover"],dataSource[@"cover_updatetime"]];
    //NSLog(@"%@",imageStr);
    [sleDetailHeader.imageHeader setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:nil];
    sleDetailHeader.delegate=self;
    //NSLog(@"%@",path);
    sleDetailHeader.tag=600;
    downPath=[NSString stringWithFormat:@"%@?modified=%@",dataSource[@"mobile"][@"file"],dataSource[@"cover_updatetime"]];
    sleeveNameID=dataSource[@"cover_updatetime"];
    NSFileManager* manger=[NSFileManager defaultManager];
    NSString* filePath=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),sleeveNameID];
    BOOL isExist= [manger fileExistsAtPath:filePath];
    if (isExist) {
        [sleDetailHeader.downlondBtn setTitle:@"打开" forState:UIControlStateNormal];
    }else{
        
    }
    table.tableHeaderView=sleDetailHeader;
    [table reloadData];
}

-(void)downloandSleeve:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"下载"]) {
        SleDetailHeaderView* sleDetailHeader=(id)[self.view viewWithTag:600];
        sleDetailHeader.progress.hidden=NO;
        NSLog(@"开始下载");
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        //<1>//创建NSURLSession的配置信息
        NSURLSessionConfiguration* configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        //<2>创建session对象 将配置信息与Session对象进行关联
        session=[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        
        //<3>将路径准化成NSURL
        NSURL* url=[NSURL URLWithString:downPath];
        //NSLog(@"%@",downPath);
        //<4>请求对象
        downloadrequest=[NSURLRequest requestWithURL:url];
        
        //<5>进行数据请求
        task= [session downloadTaskWithRequest:downloadrequest];
        //开始请求
        [task resume];
    }else if([btn.titleLabel.text isEqualToString:@"暂停"]){
        [btn setTitle:@"继续" forState:UIControlStateNormal];
        //<>暂停
        [task cancelByProducingResumeData:^(NSData *resumeData) {
            //resumData中存放的就是下载下来的数据
            data= resumeData;
        }];
    }else if([btn.titleLabel.text isEqualToString:@"继续"]){
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        if (!data) {
            NSURL* url=[NSURL URLWithString:downPath];
            downloadrequest=[NSURLRequest requestWithURL:url];
            task=[session downloadTaskWithRequest:downloadrequest];
        }else{
            //继续下载
            task= [session downloadTaskWithResumeData:data];
        }
        [task resume];
    }else{
        //打开锦囊
        SleeveHtmlWebController* sleeveHtml=[[SleeveHtmlWebController alloc]init];
        sleeveHtml.sleeveNameID=sleeveNameID;
        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:sleeveHtml];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //    SleDetailHeaderView* sleDetailHeader=(id)[self.view viewWithTag:600];
    //<1>获取存放信息的路径
    //[NSHomeDirectory() stringByAppendingString:@"/aa.txt"]
    NSString* sleevepath=[NSString stringWithFormat:@"%@/%@.zip",NSHomeDirectory(),sleeveNameID];
    NSString* destinationPath=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),sleeveNameID];
    
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath isDirectory:&isDir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error: nil];
    }
    
    NSURL* url=[NSURL fileURLWithPath:sleevepath];
    //<2>通过文件管理对象将下载下来的文件路径移到URL路径下
    NSFileManager* manager=[NSFileManager defaultManager];
    [manager moveItemAtURL:location toURL:url error:nil];
    [SSZipArchive unzipFileAtPath:sleevepath toDestination:destinationPath];
    [manager removeItemAtURL:url error:nil];
}
//获取下载进度
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //totalBytesWritten此时下载的二进制数据大小（进度）  totalBytesExpectedToWrite预期下载量
    CGFloat progress=(totalBytesWritten* 1.0)/totalBytesExpectedToWrite;
    //修改主线成
    dispatch_async(dispatch_get_main_queue(), ^{
        SleDetailHeaderView* sleDetailHeader=(id)[self.view viewWithTag:600];
        sleDetailHeader.progress.progress=progress;
        if (progress==1.0) {
            [sleDetailHeader.downlondBtn setTitle:@"打开" forState:UIControlStateNormal];
            sleDetailHeader.progress.hidden=YES;
        }
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        //NSLog(@"%@",dataSource[@"related_guides"]);
        return [dataSource[@"related_guides"] count];
    }
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            static NSString* labelCellID=@"SleeveLabelCell";
            SleeveLabelCell* labelCell=[tableView dequeueReusableCellWithIdentifier:labelCellID];
            if (labelCell==nil) {
                labelCell=[[SleeveLabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:labelCellID];
            }
            labelCell.titleLabel.text=@"锦囊简介";
            labelCell.detailText.text=dataSource[@"info"];
            return labelCell;
        }else{
            static NSString* sleeveCellID=@"SleeveUserImageCell";
            SleeveUserImageCell* labelCell=[tableView dequeueReusableCellWithIdentifier:sleeveCellID];
            if (labelCell==nil) {
                labelCell=[[SleeveUserImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sleeveCellID];
            }
            labelCell.titleLabel.text=@"锦囊作者";
            labelCell.userLaber.text=dataSource[@"authors"][0][@"username"];
            [labelCell.userImage setImageWithURL:[NSURL URLWithString:dataSource[@"authors"][0][@"avatar"]] placeholderImage:nil options:nil];
            labelCell.detailText.text=dataSource[@"authors"][0][@"intro"];
            return labelCell;
        }
    }else{
        
        if (indexPath.row==0) {
            static NSString* closeFirstID=@"SleeveCloseFirstCell";
            SleeveCloseFirstCell* closeFirst=[tableView dequeueReusableCellWithIdentifier:closeFirstID];
            if (closeFirst==nil) {
                closeFirst=[[SleeveCloseFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:closeFirstID];
            }
            
            NSArray* dataArray=dataSource[@"related_guides"];
            
            NSString* imageStr=[NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",dataArray[indexPath.row][@"cover"],dataArray[indexPath.row][@"cover_updatetime"]];
            [closeFirst.sleImage setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:nil];
            closeFirst.titleLabel.text=dataArray[indexPath.row][@"cnname"];
            NSString* aireStr=[NSString stringWithFormat:@"%@/%@",dataArray[indexPath.row][@"category_title"],dataArray[indexPath.row][@"country_name_cn"]];
            closeFirst.aireLabel.text=aireStr;
            closeFirst.downlondLabel.text=[NSString stringWithFormat:@"%@次下载",dataArray[indexPath.row][@"download"]];
            
            long count=[dataArray[indexPath.row][@"cover_updatetime"] longLongValue];
            time_t it;
            it=(time_t)count;
            struct tm *local;
            local=localtime(&it);
            char buf[80];
            strftime(buf, 80, "%Y-%m-%d", local);
            closeFirst.updataLabel.text=[NSString stringWithFormat:@"%s更新",buf];
            return closeFirst;
            
        }else{
            static NSString* closeCellID=@"SleeveCloseCell";
            SleeveCloseCell* closeCell=[tableView dequeueReusableCellWithIdentifier:closeCellID];
            if (closeCell==nil) {
                closeCell=[[SleeveCloseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:closeCellID];
            }
            NSArray* dataArray=dataSource[@"related_guides"];
            
            NSString* imageStr=[NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",dataArray[indexPath.row][@"cover"],dataArray[indexPath.row][@"cover_updatetime"]];
            [closeCell.sleImage setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:nil];
            closeCell.titleLabel.text=dataArray[indexPath.row][@"cnname"];
            NSString* aireStr=[NSString stringWithFormat:@"%@/%@",dataArray[indexPath.row][@"category_title"],dataArray[indexPath.row][@"country_name_cn"]];
            closeCell.aireLabel.text=aireStr;
            closeCell.downlondLabel.text=[NSString stringWithFormat:@"%@次下载",dataArray[indexPath.row][@"download"]];
            
            long count=[dataArray[indexPath.row][@"cover_updatetime"] longLongValue];
            time_t it;
            it=(time_t)count;
            struct tm *local;
            local=localtime(&it);
            char buf[80];
            strftime(buf, 80, "%Y-%m-%d", local);
            closeCell.updataLabel.text=[NSString stringWithFormat:@"%s更新",buf];
            return closeCell;
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        SleeveDisCountViewController* sleDisc=[[SleeveDisCountViewController alloc]init];
        sleDisc.sleeveID=dataSource[@"related_guides"][indexPath.row][@"id"];
        [self.navigationController pushViewController:sleDisc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 200*(HEIGHT/667.0);
        }else{
            return 200*(HEIGHT/667.0);
        }
    }else{
        if (indexPath.row==0) {
            return 130*(HEIGHT/667.0);
        }else{
            return 100*(HEIGHT/667.0);
        }
    }
    
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
