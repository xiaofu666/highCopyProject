//
//  WSChatTableViewController.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTableViewController.h"
#import "WSChatModel.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatImageTableViewCell.h"
#import "WSChatVoiceTableViewCell.h"
#import "WSChatTimeTableViewCell.h"
#import "WSChatMessageInputBar.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WSChatTableViewController+CoreData.h"
#import "WSChatTableViewController+MoreViewClick.h"
#import "NSObject+CoreDataHelper.h"
#import "ODRefreshControl.h"

#import "WSBuddyGroupModel.h"

#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])


@interface WSChatTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)WSChatMessageInputBar *inputBar;


@end

@implementation WSChatTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"张金磊";
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeBottom];

    
    [self.view addSubview:self.inputBar];
    [self.inputBar autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTop];
    [self.inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"自动发消息" style:UIBarButtonItemStyleDone target:self action:@selector(testInserNewobject)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollToBottom:NO];
}

#pragma mark - TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CGFloat height = model.height.floatValue;
    
    if (!height)
    {
        height = [tableView fd_heightForCellWithIdentifier:kCellReuseID(model) configuration:^(WSChatBaseTableViewCell* cell)
                  {
                      [cell setModel:model];
                  }];
        
        model.height = @(height);
        
    }
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    WSChatBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID(model) forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)configureCell:(WSChatBaseTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.model = model;
}

#pragma mark - UIResponder actions
-(void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo
{
    WSChatModel *model = [userInfo objectForKey:kModelKey];
    
    switch (eventType)
    {
        case EventChatCellTypeSendMsgEvent:
       
            [self.view endEditing:YES];
            [self SendMessage:userInfo];
            
            break;
        case EventChatCellRemoveEvent:
        
            [self RemoveModel:model];
            
            break;
        case EventChatCellImageTapedEvent:
            NSLog(@"点击了图片了。。");
            
            break;
        case EventChatCellHeadTapedEvent:
            NSLog(@"头像被点击了。。。");
            break;
        case EventChatCellHeadLongPressEvent:
            NSLog(@"头像被长按了。。。。");
            break;
        case EventChatMoreViewPickerImage://选择图片
            [self pickerImages:9];
            break;
        default:
            break;
    }

}


-(void)SendMessage:(NSDictionary*)userInfo
{
    
    WSChatModel *newModel = [WSChatModel insertNewObjectInManagedObjectContext:self.managedObjectContext];
    
    newModel.chatCellType = userInfo[@"type"];
    newModel.isSender     = @(YES);
    newModel.timeStamp    = [NSDate date];
    
    switch ([newModel.chatCellType integerValue])
    {
        case WSChatCellType_Text:
            
             newModel.content      = userInfo[@"text"];
            
            break;
            
        default:
            break;
    }
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    [self scrollToBottom:YES];
}


/**
 *  @brief  删除模型
 *
 *  @param model 模型
 */
-(void)RemoveModel:(WSChatModel *)model
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:model];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

//测试发送数据
-(void)testInserNewobject
{
    static NSTimer *timer;
    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }else
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(insertNewObject:) userInfo:nil repeats:YES];
    }
    
}


- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    WSChatModel *model =[WSChatModel insertNewObjectInManagedObjectContext:context];
   
    WSBuddyGroupModel *group;

        
    WSBuddyModel *buddy = [WSBuddyModel insertNewObjectInManagedObjectContext:self.managedObjectContext];
    
    NSArray *groupNames = @[@"我的设备",@"手机通讯录",@"小学同学",@"高中同学",@"校友",@"我的基友",@"大学室友",@"我的粉丝",@"一起回家",@"公司同事"];
    
    static int i=0;
    
    NSArray *strs = @[@"在么，有急事",
                      @"有事说事，别磨磨唧唧的。。。。。",
                      @"及时组织防化专业力量，先后9次进入爆炸现场，采集了土壤样品、检测沾染的数据，获得第一手资料。主要查明有害物质的种类、位置和危险程度，为现场指挥、决策和组织救援提供可靠的依据。",
                      @"史鲁泽说，事故核心区危险减弱了以后，16日上午，北京卫戍区防化团在爆炸现场附近的前方指挥部，军事医学科学院毒物药物研究所研究小组介绍，截至11时左右，从现场搜救的官兵等人员身上还没有发现化学沾染病例。",
                      @"呵呵呵呵，，你在逗我么？？吾问无为谓吾问无为谓吾问无为谓吾问无为谓吾问无为谓吾问无为谓哇哇哇哇吾问无为谓吾问无为谓哇哇哇哇吾问无为谓我放假打算离开了房间的撒娇，你知道我什么意思吧？"];

    
    switch (i++%4)
    {
        case 0:
        
            
            model.chatCellType = @(WSChatCellType_Image);
            model.content = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"app%d",i%8+1] withExtension:@"png"].absoluteString;
            
            break;
        case 1:
            
            model.chatCellType = WSChatCellType_Time;
            
            model.content = @"下午9:00";
            
            break;
        case 2:
            
            model.chatCellType = @(WSChatCellType_Audio);
            
            model.secondVoice = @(i%60);
            
            break;
       
        default:
            
            model.chatCellType = @(WSChatCellType_Text);
            
            model.content = strs[i%5];
            
            
            
            break;
    }
    
    NSString *name = groupNames[i%10];
    group = [WSBuddyGroupModel selectObjectInManagedObjectContext:context withGroupName:name];
    
    if (!group)
    {
        group = [WSBuddyGroupModel insertNewObjectInManagedObjectContext:context];
    }
   
    group.groupName = name;
    buddy.lastSignature = strs[i%5];
    buddy.nickName = @"张三";
    
    buddy.group = group;
    
    model.isSender = @(NO);
    model.timeStamp = [NSDate date];
    
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self scrollToBottom:YES];
}



#pragma mark - Getter Method

-(UITableView *)tableView
{
    if (_tableView)
    {
        return _tableView;
    }
    
    _tableView                      =   [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.fd_debugLogEnabled   =   NO;
    _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor      =   kBkColorTableView;
    _tableView.delegate             =   self;
    _tableView.dataSource           =   self;
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    
    _refreshControl                 =  [[ODRefreshControl alloc]initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(loadMoreMsg) forControlEvents:UIControlEventValueChanged];
    
    [_tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@1,@(WSChatCellType_Text))];
    [_tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@0,@(WSChatCellType_Text))];
    
    [_tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@1, @(WSChatCellType_Image))];
    [_tableView registerClass:[WSChatImageTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@0, @(WSChatCellType_Image))];
    
    [_tableView registerClass:[WSChatVoiceTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@0, @(WSChatCellType_Audio))];
    [_tableView registerClass:[WSChatVoiceTableViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(@1, @(WSChatCellType_Audio))];
    
    [_tableView registerClass:[WSChatTimeTableViewCell class] forCellReuseIdentifier:kTimeCellReusedID];
    
    return _tableView;
}

-(WSChatMessageInputBar *)inputBar
{
    if (_inputBar) {
        return _inputBar;
    }
    
    _inputBar = [[WSChatMessageInputBar alloc]init];
    _inputBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    return _inputBar;
}

@end
