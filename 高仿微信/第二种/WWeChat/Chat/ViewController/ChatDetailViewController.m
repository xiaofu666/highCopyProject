//
//  ChatDetailViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "GroupCell.h"
#import "PrivateCell.h"
#import "WWeChatApi.h"
#import "WZXTimeStampToTimeTool.h"
#import "MessageModel.h"
#import "KeyboardView.h"
@interface ChatDetailViewController()<RCIMClientReceiveMessageDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)KeyboardView * keyView ;


@property(nonatomic,strong)UITableView * tableView ;

@property(nonatomic,strong)NSArray * dataArr ;

@property(nonatomic,assign)NSInteger  num;
@end
@implementation ChatDetailViewController
{
    /** 对面的头像 */
    NSString * _avaterUrl;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self preData];
    // 设置消息接收监听
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      _num = 20;
    self.title = _name;
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self createUI];
}

- (void)showMessage
{
   
}

- (void)preData
{
   
    [[WWeChatApi giveMeApi]selectUserForMid:_converseID andSuccess:^(id response) {
       
        _avaterUrl = response[@"avater"];
        
    } andFailure:^{
        
    } andError:^(NSError *error) {
        
    }];
    
    //获取会话信息
    [[WWeChatApi giveMeApi]getMessagesWithConversationID:_converseID andNum:20 andType:_conversationType AndSuccess:^(NSArray *messageArr) {
        
        for (NSDictionary * dic in messageArr)
        {
            NSLog(@"%@",dic);
        }
        
        _dataArr = messageArr;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_tableView)
            {
                [_tableView reloadData];
            }
            else
            {
                [self createTableView];
            }
            [self refresh];
        });
       
    } andFailure:^{
        
    } andError:^(NSError *error) {
        
    }];
    
 
    
    
    
}

- (void)createTableView
{
    _tableView = ({
    
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSceenWidth, kSceenHeight - 64 - 50) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.backgroundColor = [UIColor clearColor];
        
        [tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMessageField)]];
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (void)hideMessageField
{
    [_keyView.messageField resignFirstResponder];
}

- (void)createUI
{
    _keyView = ({
    
        KeyboardView * keyView = [[KeyboardView alloc]initWithFrame:CGRectMake(0, kSceenHeight - 50, kSceenWidth, 50)];
        
        __weak typeof(KeyboardView) * weakKeyView = keyView;
        
        [keyView setShowBlock:^(NSInteger anType, CGFloat duration, CGSize kSize) {
            
                [UIView animateKeyframesWithDuration:duration delay:0 options:anType animations:^{
                    
                    
                    CGRect rect = weakKeyView.frame;
                    
                    rect.origin.y -= kSize.height;
                    
                    weakKeyView.frame = rect;
                    
                    CGRect tableRect = _tableView.frame;
                    
                    tableRect.size.height -= kSize.height;
                    
                    _tableView.frame = tableRect;
                    
                    CGFloat contentY = 0;
                    
                    for (NSDictionary * messageDic in _dataArr)
                    {
                        NSArray * modelArr = messageDic[@"messages"];
                        for (int i = 0; i < modelArr.count; i++)
                        {
                            MessageModel * model = modelArr[i];
                            if (i != modelArr.count - 1&& i != modelArr.count - 2)
                            {
                               contentY += model.bubbleSize.height > 40 ? model.bubbleSize.height + 20: 40+20;
                            }
                        }
                    }
                    
                    CGPoint pt = _tableView.contentOffset;
                    
                    if (contentY > kSize.height)
                    {
                        pt.y += kSize.height;
                    }
                    else
                    {
                        pt.y = contentY - 40;
                    }
                    
                    _tableView.contentOffset = pt;
                    
                } completion:^(BOOL finished) {
                    
                }];
            
        } andHideBlock:^(NSInteger anType, CGFloat duration, CGSize kSize) {
            
                [UIView animateKeyframesWithDuration:duration delay:0 options:anType animations:^{
                    
                    CGRect rect = weakKeyView.frame;
                    
                    rect.origin.y += kSize.height;
                    
                    weakKeyView.frame = rect;
                    
                    CGRect tableRect = _tableView.frame;
                    
                    tableRect.size.height += kSize.height;
                    
                    _tableView.frame = tableRect;
                    
                } completion:^(BOOL finished) {
                    
                }];
            
        }];
        
        keyView.sentBlock = ^(id response,SentMessageType type)
        {
            if (type == SentMessageTypeText)
            {
                NSString * message = (NSString *)response;
                [[WWeChatApi giveMeApi]sentTextMessageToTargetId:_converseID andConversationType:_conversationType andMessage:message andSuccess:^(id response) {
                    
                    [self preData];
                    
                } andFailure:^{
                    
                } andError:^(NSError *error) {
                    
                }];
            }
            else if(type == SentMessageTypeImg)
            {
            
            }
            else if(type == SentMessageTypeWav)
            {
                
            }
        };
        
        keyView;
    });
    [self.view addSubview:_keyView];
}

#pragma mark -- tableView --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dic = _dataArr[section];
    NSArray * arr = dic[@"messages"];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //群聊
    if (_conversationType == ConversationType_GROUP)
    {
        GroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
        if (cell == nil)
        {
            cell = [[NSBundle mainBundle]loadNibNamed:@"GroupCell" owner:self options:nil][0];
        }
        return cell;
    }
    //私聊
    else if(_conversationType == ConversationType_PRIVATE)
    {
        GroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PrivateCell"];
        if (cell == nil)
        {
            cell = [[NSBundle mainBundle]loadNibNamed:@"PrivateCell" owner:self options:nil][0];
        }
        return cell;
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_conversationType == ConversationType_PRIVATE)
    {
        PrivateCell * privateCell = (PrivateCell *)cell;
        
        NSDictionary * dic = _dataArr[indexPath.section];
        NSArray * arr = dic[@"messages"];
        
        MessageModel * model = arr[indexPath.row];
        [privateCell setModel:model];
        
        if (model.isMe == NO)
        {
            [privateCell.AiConView setImageWithURL:[NSURL URLWithString:_avaterUrl] placeholderImage:_heAvaterImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = _dataArr[indexPath.section];
    NSArray * arr = dic[@"messages"];
    MessageModel * model = arr[indexPath.row];
    return model.bubbleSize.height > 40 ? model.bubbleSize.height + 20: 40+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 60)/2.0, 10, 60, 20)];
    
    NSDictionary * dic = _dataArr[section];
    
    timeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    timeLabel.layer.cornerRadius = 5;
    timeLabel.clipsToBounds = YES;
    
    double times = [dic[@"timestamp"]doubleValue];
    
    timeLabel.text = [[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:times andScale:3]];
    
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    timeLabel.textColor = [UIColor whiteColor];
    
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:timeLabel];
    
    return headerView;
}

#pragma mark -- IM --
- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object {
    
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
    }
    //没有未接受的消息时刷新
    if (nLeft == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self preData];
                       });
    }
    
    NSLog(@"还剩余的未接收的消息数：%d", nLeft);
}

/** tableview滑到底部 */
- (void)refresh
{
    NSDictionary * dic = _dataArr.lastObject;
    NSArray * arr = dic[@"messages"];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:arr.count - 1 inSection:_dataArr.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
