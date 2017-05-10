//
//  AddressBookViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "AddressBookViewController.h"
#import "NSString+PinYin.h"
#import "WWeChatApi.h"
#import "PersonModel.h"
#import "AddFriendViewController.h"
@interface AddressBookViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate>

@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UISearchController * searchController;

@property(nonatomic,copy)NSArray * sectionArr;

@property(nonatomic,strong)NSMutableArray * searchArr;

@end

@implementation AddressBookViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self preData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addRightBtnWithImgName:@"book_addfriend" andSelector:@selector(rightBtnClick:)];
    //准备数据
    [self preData];
    
    [self createTableView];
}

- (void)preData
{
    
    _searchArr = [[NSMutableArray alloc]init];
    
    _sectionArr = @[
                    @{
                        @"name":@"新的朋友",
                        @"imgName":@"book_newfriend"
                     },
                    @{
                        @"name":@"群聊",
                        @"imgName":@"book_group"
                     },
                    @{
                        @"name":@"标签",
                        @"imgName":@"book_tag"
                     },
                    @{
                        @"name":@"公众号",
                        @"imgName":@"book_gong"
                     }
                    ];
    
    NSMutableArray * nameArr = [[NSMutableArray alloc]init];
    
    [[WWeChatApi giveMeApi]askForFriendAndSuccess:^(id response) {
        _dataArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary * dic in response)
        {
            PersonModel * model = [[PersonModel alloc]init];
            model.nickName = dic[@"name"];
            model.avater = dic[@"avater"];
            model.ObjectID = dic[@"objectID"];
            [nameArr addObject:model];
        }
        
        // #数组
        NSMutableArray * otherArr = [[NSMutableArray alloc]initWithArray:nameArr];
        // 已经被添加的数组
        NSMutableArray * addArr = [[NSMutableArray alloc]init];
        
        for(char i = 'A';i <= 'Z';i++)
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            for (int j = 0; j < nameArr.count; j++)
            {
                PersonModel * model = nameArr[j];
                NSString * sectionName = [NSString stringWithFormat:@"%c",i];
                
                //属于这个组的nameArr
                NSMutableArray * currNameArr = [[NSMutableArray alloc]init];
                if ([[model.nickName getFirstLetter] isEqualToString:sectionName])
                {
                    [currNameArr addObject:model];
                    [addArr addObject:model];
                }
                
                if (currNameArr.count > 0)
                {
                    [dic setObject:currNameArr forKey:@"nameArr"];
                    [dic setObject:sectionName forKey:@"sectionName"];
                    [_dataArr addObject:dic];
                }
            }
        }
        
        [otherArr removeObjectsInArray:addArr];
        
        [_dataArr addObject:@{
                              @"nameArr" : otherArr,
                              @"sectionName" : @"#"
                              }];
        
        NSLog(@"%@",_dataArr);
        
       if(_tableView)
       {
           [_tableView reloadData];
       }
        
    } andFailure:^{
        
    } andError:^(NSError *error) {
        
    }];
    
    
   
}

- (void)createTableView
{
    _tableView = ({
    
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStyleGrouped];
    
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        //调整下分隔线位置
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (void)rightBtnClick:(UIButton *)sender
{
    AddFriendViewController * addVC = [[AddFriendViewController alloc]init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark --tableView--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _sectionArr.count;
    }
    else
    {
        NSDictionary * dic = _dataArr[section - 1];
        NSArray * arr = dic[@"nameArr"];
        return arr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"bookCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSDictionary * dic = _sectionArr[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:dic[@"imgName"]];
        
        cell.textLabel.text = dic[@"name"];
    }
    else
    {
        
        NSDictionary * dic = _dataArr[indexPath.section - 1];
        
        NSArray * arr = dic[@"nameArr"];
        
        //当前cell的信息
        PersonModel * model = arr[indexPath.row];
        
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.avater] placeholderImage:[UIImage imageNamed:@"avater.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
        }];
        
        cell.textLabel.text = model.nickName;
        
        UIImage *icon = cell.imageView.image;
        
        //修改icon尺寸
        CGSize itemSize = CGSizeMake(WGiveWidth(36), WGiveWidth(36));
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WGiveHeight(55);
}



//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(43);
    }
    return WGiveHeight(20);
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WGiveHeight(0.01);
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WGiveWidth(30), WGiveHeight(20))];
        
        NSDictionary * dic = _dataArr[section - 1];

        label.text = [NSString stringWithFormat:@"   %@",dic[@"sectionName"]];
    
        label.textAlignment = NSTextAlignmentLeft;
        
        label.font = [UIFont systemFontOfSize:10];
        
        label.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:146/255.0 alpha:1];
        
        return label;
    }
    //搜索框
    else
    {
        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        //self.searchController.searchResultsUpdater = self;
        
        self.searchController.dimsBackgroundDuringPresentation = NO;
        
        [self.searchController.searchBar sizeToFit];
        
        //self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        self.searchController.delegate = self;
        
        self.searchController.searchBar.backgroundImage = [[UIImage alloc]init];
        
        self.searchController.searchBar.placeholder = @"搜索";
        
        self.searchController.searchBar.tintColor = WXGreen;
        return self.searchController.searchBar;
    }
    return nil;
}

- (void)willPresentSearchController:(UISearchController *)searchController
{
    [self.glassView showToView:self.view];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    [self.glassView hide];
}

//加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    //索引背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    //索引颜色
    tableView.sectionIndexColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    
    //加放大镜
    [arr addObject:UITableViewIndexSearch];
    
    for (NSDictionary * dic in _dataArr)
    {
        [arr addObject:dic[@"sectionName"]];
    }
    return arr;
}

#pragma mark --选中Cell的方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - searchController delegate

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
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
