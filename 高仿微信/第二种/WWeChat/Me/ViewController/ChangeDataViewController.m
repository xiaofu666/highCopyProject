//
//  ChangeDataViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/15.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChangeDataViewController.h"
#import "ChangeAvaterView.h"
#import "UserInfoManager.h"
#import "WWeChatApi.h"

@interface ChangeDataViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)ChangeAvaterView * changeView;

@property(nonatomic,strong)UITextField * nickNameField;

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation ChangeDataViewController
{
    ChangeType _type;
}
- (instancetype)initWithType:(ChangeType)type
{
    if (self = [super init])
    {
        _type = type;
        
        self.view.userInteractionEnabled = YES;
        
        self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        switch (type)
        {
            //更改头像
            case ChangeAvater:
            {
                self.title = @"个人头像";
                self.view.backgroundColor = [UIColor blackColor];
                [self addRightBtnWithImgName:@"ChangeData_more" andSelector:@selector(createChangeView)];
            }
                break;
    
                
            //更改昵称
            case ChangeNickName:
            {
                self.title = @"名字";
                [self addLeftBtnWithStr:@"取消" andSelector:@selector(leftNavCancelClick:)];
                
                UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                rightBtn.frame = CGRectMake(0, 0,40, 44);
                [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
                [rightBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:92/255.0 blue:52/255.0 alpha:1] forState:UIControlStateDisabled];
                [rightBtn setTitleColor:[UIColor colorWithRed:36/255.0 green:186/255.0 blue:36/255.0 alpha:1] forState:UIControlStateNormal];
                [rightBtn addTarget:self action:@selector(changeNickRightClick:) forControlEvents:UIControlEventTouchUpInside];
                
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
                [self createChangeNickNameUI];
            }
                break;
                
            //更改地址
            case ChangeAddress:
            {
                
            }
                break;
             
            //更改性别
            case ChangeSex:
            {
                self.title = @"性别";
                [self.view addSubview:self.tableView];
            }
                break;
             
            //更改地区
            case ChangePath:
            {
                
            }
                break;
            
            //更改签名
            case ChangeSign:
            {
                self.title = @"个性签名";
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

//取消按钮
- (void)leftNavCancelClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 个性签名部分 --

#pragma mark -- 修改性别部分 --
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
            
            tableView.showsVerticalScrollIndicator = NO;
            
            tableView.delegate = self;
            tableView.dataSource = self;
            
            tableView;
        });
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return @[@"男",@"女"].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WGiveHeight(15);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WGiveHeight(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString * identifier = @"ChangeSexCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row == 0?@"男":@"女";
   
    if ([cell.textLabel.text isEqualToString:[[UserInfoManager manager]sex] == YES?@"男":@"女"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WWeChatApi giveMeApi]updataSexWithIsMan:indexPath.row == 0?YES:NO andSuccess:^(id response) {
        
        [hub hideAnimated:YES];
        [self.tableView reloadData];
        
    } andFailure:^(NSError *error) {
        
    }];
}

#pragma mark -- 修改昵称部分 --

- (void)createChangeNickNameUI
{
    self.nickNameField.text = [[UserInfoManager manager]userName];
}

- (void)changeNickRightClick:(UIButton *)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [[WWeChatApi giveMeApi]updataUserNameWithName:_nickNameField.text andSuccess:^(id response) {
        [hud hideAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } andFailure:^(NSError *error) {
        
    }];
}

- (UITextField *)nickNameField
{
    if (!_nickNameField)
    {
        _nickNameField = [[UITextField alloc]initWithFrame:CGRectMake(0, WGiveHeight(15+64), self.view.frame.size.width, WGiveHeight(45))];
        _nickNameField.backgroundColor = [UIColor whiteColor];
        _nickNameField.clearButtonMode = UITextFieldViewModeAlways;
        [_nickNameField becomeFirstResponder];
        [_nickNameField addTarget:self action:@selector(changeFieldText:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_nickNameField];
    }
    return _nickNameField;
}

- (void)changeFieldText:(UITextField *)sender
{
    NSLog(@"change");
    if ([sender.text isEqualToString:[[UserInfoManager manager]userName]])
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        if (sender.text.length > 0)
        {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
}

#pragma mark -- 修改头像部分 --

- (void)createChangeView
{
    if (!_changeView)
    {
        _changeView = [[ChangeAvaterView alloc]initWithFrame:self.view.bounds andBtnArr:@[
                                                                                          @"拍照",
                                                                                          @"从手机相册选择",
                                                                                          @"保存图片"
                                                                                          ]];
        UIButton * cameraBtn = (UIButton *)[_changeView viewWithTag:_changeView.thisTag + 0];
        UIButton * photoBtn = (UIButton *)[_changeView viewWithTag:_changeView.thisTag + 1];
        UIButton * saveBtn = (UIButton *)[_changeView viewWithTag:_changeView.thisTag + 2];
        [cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [photoBtn addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_changeView];
    [_changeView show];
}

- (void)cameraBtnClick:(UIButton *)sender
{
    [_changeView hide];
    NSLog(@"拍照");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{

        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)photoClick:(UIButton *)sender
{
    [_changeView hide];
    NSLog(@"相册");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{

    }];
}

- (void)saveClick:(UIButton *)sender
{
  [_changeView hide];
  UIImageWriteToSavedPhotosAlbum(self.avaterView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        hud.mode = MBProgressHUDModeCustomView;
        
        UIImage * CheckImage = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        hud.customView = [[UIImageView alloc] initWithImage:CheckImage];
        
        hud.square = YES;
        hud.label.text = @"保存成功";
        
        [hud hideAnimated:YES afterDelay:1.f];
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{

    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];

    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
//        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage * smallImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.width)];
//        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{

            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"正在上传头像";
            [[WWeChatApi giveMeApi]updataAvaterWithImg:smallImage andSuccess:^(id response) {
                
                _avaterView.image = smallImage;
                
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [[UserInfoManager manager]saveImgDataWithImg:smallImage];

            } andFailure:^(NSError *error) {

                NSLog(@"error:%@",error.localizedDescription);
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];

            }];

        }];

    }

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}

- (UIImageView *)avaterView
{
    if (!_avaterView)
    {
        _avaterView = [[UIImageView alloc]initWithFrame:CGRectMake(0, WGiveHeight(130), self.view.frame.size.width, self.view.frame.size.width)];
        [self.view addSubview:_avaterView];
    }
    return _avaterView;
}

//压缩图片方法
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);

    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    // End the context
    UIGraphicsEndImageContext();

    // Return the new image.
    return newImage;
}

@end
