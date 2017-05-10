//
//  RJFViewController.m
//  AppRecommand
//
//  Created by jiangyu on 13-1-9.
//  Copyright (c) 2013年 jiangyu. All rights reserved.
//

#import "RJFViewController.h"

@interface RJFViewController ()

@end

@implementation RJFViewController

@synthesize fileHost = m_strHost;
@synthesize fileport = m_ifilePort;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    m_arrStoreDatasource  = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"精彩应用推荐";
    UIImage *image = [UIImage imageNamed:@"nav_bg.png"];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    //    CGSize  size = self.navigationController.navigationBar.frame.size;
    //    image = [image imageByScalingAndCroppingForSize:size];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    
    m_av = [[[UIAlertView alloc] initWithTitle:@"提示"
                                       message:@"加载应用程序信息中！请稍候"
                                      delegate:nil
                             cancelButtonTitle:nil
                             otherButtonTitles:nil, nil]autorelease] ;
    CGFloat  fwidth = 80;
    UIActivityIndicatorView  * aci = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(95, 50, fwidth, fwidth)];
    [aci startAnimating];
    [m_av addSubview:aci];
    [aci release];
    [m_av show];
    
    UIBarButtonItem * item = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back:)]autorelease];
    self.navigationItem.leftBarButtonItem = item;//[self barbuttonItemWithImage:@"back.png" withTarget:@selector(back:)];
    [super viewDidLoad];
    
    m_appDownload = [[RJFAppDownload alloc] initWithHost:APPSERVERHOST
                                                    Port:APPSERVERPORT
                                                Delagate:self
                                                   AppID:eAE_OPOPO_I366];
    
    tabelView = [[[UITableView alloc]init]autorelease];
    [tabelView setDelegate:self];
    [tabelView setDataSource:self];
    self.view = tabelView;
    
}
-(UIBarButtonItem *)barbuttonItemWithImage:(NSString *)imageName withTarget:(SEL)target
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 43, 36)];
    // imageView.image = [UIImage imageNamed:@"button_bg.png"];
    imageView.userInteractionEnabled = YES;
    UIButton    *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 36)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //btnDraft.backgroundColor = [UIColor blueColor];
    [imageView addSubview:btn];
    [btn addTarget:self
            action:target forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[[UIBarButtonItem alloc] initWithCustomView:imageView] autorelease];
    [btn release];
    [imageView release];
    return barItem;
}

-(void)back:(id)sender
{
    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [m_appDownload disConnect];
    [super viewDidDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //    return 0;
    if (m_arrStoreDatasource){
        return m_arrStoreDatasource.count;
    }else
        return 0;
//    return [m_arrStoreDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
     UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"q"] autorelease];
        CGFloat   Xpoint = 5;
        CGFloat   XSep = 5;
        
        RjfDownPicImageView   *imageView  = [[RjfDownPicImageView alloc] initWithFrame:CGRectMake(Xpoint, 5, 50, 50)];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
        [imageView release];
        
        Xpoint += 50+XSep;
        
        UIFont  *font = [UIFont systemFontOfSize:12];
        UILabel  *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint-5, 2, 100, 30)];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setTextAlignment:NSTextAlignmentRight];
        [labelTitle setTextColor:[UIColor blackColor]];
        labelTitle.tag = 2;
        [labelTitle setFont:[UIFont systemFontOfSize:16]];
        [cell.contentView addSubview:labelTitle];
        [labelTitle release];
        
        
        UILabel  *labelSize = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 35, 100, 20)];
        [labelSize setFont:font];
        [labelSize setBackgroundColor:[UIColor clearColor]];
        [labelSize setTextColor:[UIColor darkTextColor]];
        labelSize.tag = 3;
        [cell.contentView addSubview:labelSize];
        [labelSize release];
        
        Xpoint += 100+XSep;
        UILabel  *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 3, 70, 25)];
        [labelVersion setBackgroundColor:[UIColor clearColor]];
        labelVersion.tag = 4;
        [labelVersion setFont:font];
        [cell.contentView addSubview:labelVersion];
        [labelVersion setTextColor:[UIColor blackColor]];
        [labelVersion release];
        
        UILabel  *labelUpdateTime = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint-25, 3+25+3, 100, 25)];
        [labelUpdateTime setBackgroundColor:[UIColor clearColor]];
        labelUpdateTime.tag = 5;
        [labelUpdateTime setFont:font];
        [cell.contentView addSubview:labelUpdateTime];
        [labelUpdateTime setTextColor:[UIColor darkTextColor]];
        [labelUpdateTime release];
        
        Xpoint += 76+XSep;
        UIButton  *btnDoload = [[UIButton alloc] initWithFrame:CGRectMake(Xpoint, 12.5, 65, 35)];
        btnDoload.tag = 6;
        [btnDoload addTarget:self
                      action:@selector(downApp:)
            forControlEvents:UIControlEventTouchUpInside];
        [btnDoload setTitle:@"下载" forState:UIControlStateNormal];
        [btnDoload setBackgroundImage:[UIImage imageNamed:@"downloadApp.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:btnDoload];
        [btnDoload release];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    // Configure the cell...
    UIView  *view = [cell contentView];
    NSDictionary  *dicInfo = [m_arrStoreDatasource objectAtIndex:indexPath.row];
    
    RjfDownPicImageView  *imageView = (RjfDownPicImageView *)[view viewWithTag:1];
    [imageView StartDownPic:[dicInfo valueForKey:SOFTARELOGO] requestID:DOWNAPPPICID fileServer:self.fileHost port:self.fileport];
    // imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicInfo valueForKey:SOFTARELOGO]]]];
    
    
    UILabel  *label =(UILabel *)[view viewWithTag:2];
    [label setText:[dicInfo valueForKey:SOFTAREDESPRICTION]];
    label = (UILabel *)[view viewWithTag:3];
    
    CGFloat size = [[dicInfo valueForKey:SOFTARESIZE]intValue];
    [label setText:[NSString stringWithFormat:@"大小:%.2fMB",size/1024]];
    label = (UILabel *)[view viewWithTag:4];
    [label setText:[NSString stringWithFormat:@"版本：%@",[dicInfo valueForKey:SOFTAREVERSION]]];
    label = (UILabel *)[view viewWithTag:5];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dicInfo valueForKey:SOFTAREUPDATETIME] floatValue]];
    NSDateFormatter  *forma = [[NSDateFormatter alloc] init];
    [forma setDateFormat:@"yy/mm/dd"];
    NSString *strDate = [forma stringFromDate:date];
    [forma release];
    
    NSLog(@"date:%@",strDate);
    [label setText:[NSString stringWithFormat:@"更新日期:%@",strDate]];
    //    label.text = [NSString stringWithFormat:@"下载：%@",[dicInfo valueForKey:SOFTAREDOWNNUMBER]];
    
    return cell;
}
-(void)downApp:(UIButton*)sender
{
    CGPoint point = sender.center;
    point = [tabelView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [tabelView indexPathForRowAtPoint:point];
    NSDictionary  *dicInfo = [m_arrStoreDatasource objectAtIndex:indexpath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dicInfo valueForKey:SOFTAREURL]]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

 

#pragma mark - Table view delegate


-(void)receiveAppInfo:(NSDictionary *)dicInfo
{
    if (dicInfo == nil)
    {
        return;
    }
    if (m_av) {
        //        m_av.superview = nil;
        [m_av dismissWithClickedButtonIndex:0 animated:YES];
    }
    //    NSLog(@"Dicinfo:%@",dicInfo);
    if ([dicInfo valueForKey:@"FILESERVERHOST"])
    {
        self.fileHost = [dicInfo valueForKey:@"FILESERVERHOST"];
    }
    if ([dicInfo valueForKey:@"FILESERVERPORT"])
    {
        self.fileport = [[dicInfo valueForKey:@"FILESERVERPORT"] intValue];
    }
    
    NSLog(@"%@",dicInfo);
    [m_arrStoreDatasource removeAllObjects];
    
    [m_arrStoreDatasource addObjectsFromArray:[dicInfo valueForKey:@"SOFTARRAYINO"]];
    
    NSLog(@"%@",[dicInfo allKeys]);
    [tabelView reloadData];
}

-(void) DisConnectError{
    
    UIAlertView  *av = [[[UIAlertView alloc] initWithTitle:@"提示"
                                                   message:@"当前没有可以推荐的应用！"
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                         
                                         otherButtonTitles:nil, nil] autorelease];
    [av show];
    if (m_av) {
        //        m_av.superview = nil;
        [m_av dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void)dealloc
{
//    if (m_av) {
//        [m_av release];
//    }
    //    if (btnBack)
    //    {
    //        [btnBack release];
    //        btnBack = nil;
    //    }
    //    if (m_tableView)
    //    {
    //        [m_tableView release];
    //        m_tableView = nil;
    //    }
    if(tabelView){
        [tabelView release];
        tabelView = nil;
    }
    if (m_arrStoreDatasource)
    {
        [m_arrStoreDatasource removeAllObjects];
        [m_arrStoreDatasource release];
        m_arrStoreDatasource = nil;
    }
    if (m_appDownload)
    {
        [m_appDownload release];
        m_appDownload = nil;
    }
    [super dealloc];
}


@end
