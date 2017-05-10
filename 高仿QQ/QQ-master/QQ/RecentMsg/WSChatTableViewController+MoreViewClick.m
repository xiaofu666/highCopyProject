//
//  WSChatTableViewController+MoreViewClick.m
//  QQ
//
//  Created by weida on 16/1/22.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTableViewController+MoreViewClick.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "WSChatModel.h"
#import "NSObject+CoreDataHelper.h"

@implementation WSChatTableViewController (MoreViewClick)

-(void)pickerImages:(NSInteger)maxCount;
{
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusCameraRoll;// 默认显示相册里面的内容SavePhotos
    pickerVc.maxCount = maxCount;
    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets)
    {
        for (MLSelectPhotoAssets *image in assets)
        {
            WSChatModel *newModel = [WSChatModel insertNewObjectInManagedObjectContext:weakSelf.managedObjectContext];
            newModel.chatCellType = @(WSChatCellType_Image);
            newModel.isSender     = @(YES);
            newModel.timeStamp    = [NSDate date];
            newModel.sendingImage = image.thumbImage;
            NSLog(@"%@",image.assetURL);
        }
        
        NSError *error = nil;
        if (![weakSelf.managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    };
    

}

@end
