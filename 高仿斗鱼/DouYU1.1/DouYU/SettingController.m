//
//  SettingController.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "SettingController.h"
#import "SectionView.h"
#import "SwithCell.h"
#import "SliderCell.h"
#import "TanLableCell.h"
#import "SliderCell.h"
#import "UMessage.h"

@interface SettingController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSArray *_dataArray;
    
    UISwitch *_cellSwith;
    
    
    CGFloat alp;
    CGFloat fot;
}

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alp=1;
    fot=17;
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNav];
    [self initTableView];
    
}

-(void)initTableView;
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
}

-(void)initNav
{
    self.navigationItem.rightBarButtonItem=nil;
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"btn_nav_back"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(CloseSetting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    self.title=@"设置";
    self.navigationItem.titleView=nil;
}

-(void)CloseSetting
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if(section==1){
        return 9;
    }else if(section==2){
        return 4;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*KWidth_Scale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45*KWidth_Scale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *FirstArray=@[@"列表自动加载",@"展示全部分类"];
    NSArray *LastArray=@[@"消息通知",@"清理缓存",@"关于我们",@"给我们评分"];
    
    if (indexPath.section==0) {
        
        SwithCell *swCell=[SwithCell GetCellWithTableView:tableView];
        swCell.selectionStyle=UITableViewCellSelectionStyleNone;
        swCell.Title.text=FirstArray[indexPath.row];
        swCell.cellSwith.tag=indexPath.row;
        [swCell.cellSwith addTarget:self action:@selector(SwithButton:) forControlEvents:UIControlEventValueChanged];
        swCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return swCell;
        
    }else if (indexPath.section==1){
    
        if (indexPath.row==0) {
            
            SwithCell *swCell=[SwithCell GetCellWithTableView:tableView];
            swCell.selectionStyle=UITableViewCellSelectionStyleNone;
            swCell.Title.text=@"播放器手势";
            swCell.cellSwith.tag=2;
            [swCell.cellSwith addTarget:self action:@selector(SwithButton:) forControlEvents:UIControlEventValueChanged];
            swCell.selectionStyle=UITableViewCellSelectionStyleNone;
            return swCell;
        }
        else if (indexPath.row==1) {
            
            TanLableCell *tancell=[TanLableCell GetCellWithTableView:tableView];
            tancell.Example.alpha=alp;
            tancell.Example.font=[UIFont systemFontOfSize:fot];

            tancell.selectionStyle=UITableViewCellSelectionStyleNone;
            return tancell;
        }
        else if  (indexPath.row==2||indexPath.row==4||indexPath.row==6) {
            
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tanmo"];
            
            if (indexPath.row==2) {
                cell.textLabel.text=@"弹幕透明度";
            }if (indexPath.row==4) {
                cell.textLabel.text=@"弹幕字号";
            }if (indexPath.row==6) {
                cell.textLabel.text=@"弹幕位置";
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if  (indexPath.row==3||indexPath.row==5) {
            
            SliderCell *sliderCell=[SliderCell GetCellWithTableView:tableView];
            if (indexPath.row==3) {
                sliderCell.Small.image=[UIImage imageNamed:@"Image_font_small"];
                sliderCell.Big.image=[UIImage imageNamed:@"Image_font_big"];
                sliderCell.Silder.tag=1;
                sliderCell.Silder.value=1;
            }else if (indexPath.row==5) {
                sliderCell.Small.image=[UIImage imageNamed:@"Image_alpha_small"];
                sliderCell.Big.image=[UIImage imageNamed:@"Image_alpha_big"];
                sliderCell.Silder.tag=2;
            }
            sliderCell.selectionStyle=UITableViewCellSelectionStyleNone;
            [sliderCell.Silder addTarget:self action:@selector(SliderChange:) forControlEvents:UIControlEventValueChanged];
            return sliderCell;
        }
        else if  (indexPath.row==7) {
            
            TanLableCell *tancell=[TanLableCell GetCellWithTableView:tableView];
            tancell.selectionStyle=UITableViewCellSelectionStyleNone;
            return tancell;
        }
        else if  (indexPath.row==8) {
            
            static NSString *lastcellID=@"lastcellID";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:lastcellID];
            if (!cell) {
                
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastcellID];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=@"休眠设置";
            return cell;
        }
        
       return nil;
    
    }else if (indexPath.section==2) {
        
        if (indexPath.row==0) {
            
            SwithCell *swCell=[SwithCell GetCellWithTableView:tableView];
            swCell.selectionStyle=UITableViewCellSelectionStyleNone;
            swCell.Title.text=LastArray[indexPath.row];;
            swCell.cellSwith.tag=3;
            [swCell.cellSwith addTarget:self action:@selector(SwithButton:) forControlEvents:UIControlEventValueChanged];
            swCell.selectionStyle=UITableViewCellSelectionStyleNone;
            return swCell;
        }else if (indexPath.row==1) {
            
            
            static NSString *lastcellID=@"lastcellID1";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:lastcellID];
            if (!cell) {
                
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:lastcellID];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.1fM",[self filePath]];
            cell.textLabel.text=LastArray[indexPath.row];
            return cell;
            
        }else{
            
            static NSString *lastcellID=@"lastcellID2";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:lastcellID];
            if (!cell) {
                
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastcellID];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=LastArray[indexPath.row];
            return cell;
        }
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        
        if (indexPath.row==1) {
            
            [self clearFile];
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *SectionArray=@[@"系统设置",@"直播设置",@"其他设置"];
    SectionView *sectionView=[[SectionView alloc]init];
    sectionView.Title.text=SectionArray[section];
    return sectionView;
}

-(void)SwithButton:(UISwitch *)sender
{
    NSLog(@"%ld",sender.tag);
    
    if (sender.tag==3) {
        
        if (sender.on) {
            
        }else{
            [UMessage unregisterForRemoteNotifications];
        }
        
    }
    
    //0 列表自动加载
    //1 展示全部分类
    //2 播放器手势
    //3 消息通知
    

}

-(void)SliderChange:(UISlider *)sender
{
    if (sender.tag==1) {
        
         alp=sender.value;
    }
    if (sender.tag==2) {
        
        fot=sender.value*30;
    }
   
    NSIndexPath *index=[NSIndexPath indexPathForRow:1 inSection:1];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
}

//*********************清理缓存********************//
// 显示缓存大小
-( float )filePath
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}
// 清理缓存

- (void)clearFile
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    
}

- (void)clearCachSuccess
{

    NSLog ( @" 清理成功 " );
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:1 inSection:2];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
