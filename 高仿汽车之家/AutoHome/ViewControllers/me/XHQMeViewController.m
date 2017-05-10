//
//  XHQMeViewController.m
//  XiaHaiQuan
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 HaiQuan. All rights reserved.
//

#import "XHQMeViewController.h"

#import "XHQ3rdLoginViewController.h"

#import "XHQFavViewController.h"

#import "RESideMenu.h"

#import "XHQAboutMeViewController.h"

#import "AppDelegate.h"



//全局的静态变量，用于多处使用，方便统一修改
static float ImageOriginHeight = 150;

@interface XHQMeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>



@property(nonatomic,strong) RESideMenu * sideMenu;
@property(nonatomic,strong)  RESideMenuItem *item1;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *MeDataSource;

@property(nonatomic,strong)UIView *darkView;

@property (nonatomic,strong)UIImageView * headerImageView;

@property(nonatomic,assign)BOOL b;

@end

@implementation XHQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.b = NO;
    [self creatDataSource];
}

- (void)creatDataSource
{
    [self.dataSource addObjectsFromArray: @[@"登录/注册",@"我的收藏",@"夜间模式",@"关于我们"]];
    self.MeDataSource = [NSArray array];
    self.MeDataSource = @[@"更多"];
    [self.tableView reloadData];
}
#pragma mark -- tableview的代理方法
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(section == 0)
   {
    return self.dataSource.count;
   }else{
       return self.MeDataSource.count;
   }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *rID = @"CELL";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:rID];
   
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rID];
    }
    
    
    if(indexPath.section == 0)
    {
        cell.textLabel.text = self.dataSource[indexPath.row];
        
        if(indexPath.row == 2)
        {
            UISwitch *swi = [[UISwitch alloc]init];
            [swi addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = swi;
        }
        
    }else if(indexPath.section == 1)
    {
        cell.textLabel.text = self.MeDataSource[indexPath.row];
       
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        
        XHQ3rdLoginViewController *loagin = [[XHQ3rdLoginViewController alloc]init];
        
        loagin.LoginSuccess = ^
        {
            self.b = YES;
        };
       
        
    [self pushNextWithType:@"cube" Subtype:@"fromLeft" Viewcontroller:loagin];
        
    }
    
    if(indexPath.section == 0  && indexPath.row == 1)
    {
        
    XHQFavViewController *fav = [[XHQFavViewController alloc]init];
    fav.title = @"我的收藏";
    [self pushNextWithType:@"cube" Subtype:@"fromLeft" Viewcontroller:fav];
        
    }else if(indexPath.section == 0 && indexPath.row == 3)
    {
//        NSString *str = @"海泉工作室以打造最专业的汽车网站为目标，已于2006年11月正式上线。建站初期凭借着丰富详实的产品信息吸引了众多汽车爱好者的关注。在这里，您可以查询到市面上在售的各品牌全部车型的详细参数及真实有效的报价，辅以最新最快的汽车市场信息，万车网成为了您在购买汽车之前的了解相关信息的最佳平台。 万车网从专业角度关注汽车市场，提供全方位的服务是网站的宗旨，灵活地整合了新闻、娱乐、服务、商务等多形式内容，涉及到了车辆买卖、车辆保险、车型对比以及汽车保养与维修等方面，为汽车厂商、汽车产业链和渠道以及最广泛的最终消费者提供了便利的服务体验。 ”海泉知道“（ask.haiquancars.com.cn）是海泉网在国内首创的专业汽车问答互动平台，2008年5月正式上线，由百余名一线品牌汽车专家组成的专业团队，每天24小时在线为全国网友一对一地解答维修保养、买车卖车、车险车务等方面的问题，目前已经成为国内最专业、最权威、人气最旺的汽车问答互动平台。 倡导汽车消费，演绎汽车文化，引领消费时尚，万车网正在向着专业化的汽车媒体迈进。目前网站的访问量正在高速地增长，知名度也在不断提升，网站的专业团队正在为提供贴心的服务与专业的咨讯而不懈努力，需要更多的信息，敬请访问www.haiquan.com.cn";
//        [XHQAuxiliary alertWithTitle:@"关于我们" message:str button:1 done:^{
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }];
        
        XHQAboutMeViewController *about = [[XHQAboutMeViewController alloc]init];
        [self pushNextWithType:@"cube" Subtype:@"fromLeft" Viewcontroller:about];
        
    }else
        if(indexPath.section == 1 && indexPath.row == 0)
       {
       
        [self More];
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        
        if(self.b)
        {
        
    
    CGRect frame = CGRectMake(0,  0, XHQ_SCRWIDTH, ImageOriginHeight);
    self.headerImageView = [XHQFactoryUI createImageViewWithFrame:frame imageName:@"welcome1"];
            
     return self.headerImageView;
        }
        return nil;
    
    }
    
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
    return ImageOriginHeight;
    }return 0;
}
#pragma mark - 实现scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //实现图头放大的核心思想：通过改变scrollView的偏移量来改变图片的frame
  if(scrollView == self.tableView)
  {
        //获取scrollView的偏移量
        float yOffset = scrollView.contentOffset.y;
        //scrollView的横向偏移量是随着纵向偏移量的变化而变化
        float xOffset = (yOffset + ImageOriginHeight) / 2;
        if (yOffset < -ImageOriginHeight) {
            //改变imageView的frame
            CGRect rect = _headerImageView.frame;
           
            rect.origin.y = -yOffset;
            rect.size.height = -yOffset * 2;
            
            rect.origin.x = xOffset;
            rect.size.width = XHQ_SCRWIDTH + fabs(xOffset) * 2;
           
            _headerImageView.frame = rect;
         //   NSLog(@"%f💐%f",rect.origin.y, rect.size.height);
       
    }
     // NSLog(@"%f",yOffset);
  }
}


- (void)changeValue:(UISwitch *)swi
{
    if (swi.on) {
        //添加半透明view到window上
        UIApplication * app = [UIApplication sharedApplication];
        AppDelegate *delegate = (AppDelegate *) app.delegate;
        _darkView = [[UIView alloc]initWithFrame:self.view.frame];
        //设置view的背景色
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha = 0.3;
        //关闭view的用户交互(响应者链)
        _darkView.userInteractionEnabled = NO;
        [delegate.window addSubview:_darkView];
        
    }
    else
    {
        [_darkView removeFromSuperview];
    }

}
- (void) More
{
    if (!_sideMenu)
    {
        
        RESideMenuItem *item1 = [[RESideMenuItem alloc]initWithTitle:@"退出登录" action:^(RESideMenu *menu, RESideMenuItem *item) {
            self.b = NO;
            [self.tableView reloadData];
            
        }];
        
       
        
        RESideMenuItem * item2 = [[RESideMenuItem alloc]initWithTitle:@"清除缓存" action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [paths lastObject];
            
            NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
            for (NSString *p in files) {
                NSError *error;
                NSString *Path = [path stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
                }
            }
            
            [XHQAuxiliary alertWithTitle:@"温馨提示" message:str button:0 done:nil];
            
            
        }];
    
        
        RESideMenuItem * item3 = [[RESideMenuItem alloc]initWithTitle:@"退出" action:^(RESideMenu *menu, RESideMenuItem *item) {
             exit(0);
          
        }];
      _sideMenu = [[RESideMenu alloc]initWithItems:@[item2,item1,item3]];
    }
    
    //设置抽屉效果显示
    [_sideMenu show];
}
- (float ) folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


#pragma mark -- 懒加载 --
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XHQ_SCRWIDTH, XHQ_SCRHEIGTH) style:UITableViewStyleGrouped  ];
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
       
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      //  _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
      
        
      [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com