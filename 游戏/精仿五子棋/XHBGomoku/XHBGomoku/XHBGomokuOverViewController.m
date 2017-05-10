//
//  XHBGomokuOverViewController.m
//  XHBGomoku
//
//  Created by weqia on 14-9-4.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import "XHBGomokuOverViewController.h"
#import "UIColor+setting.h"
@interface XHBGomokuOverViewController ()
@property(nonatomic,weak)IBOutlet UIButton * btnBack;
@property(nonatomic,weak)IBOutlet UIButton * btnRetart;
@property(nonatomic,weak)IBOutlet UIImageView * backView;
@property(nonatomic,weak)IBOutlet UILabel * labelAlert;
@property(nonatomic,weak)IBOutlet UILabel * labelMessage;
@end

@implementation XHBGomokuOverViewController
@synthesize callback;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.success) {
        self.labelAlert.text=@"Congratulations,You Won!";
    }else{
        self.labelAlert.text=@"Sorry,You Lose!";
    }
    self.view.backgroundColor=[UIColor colorWithIntegerValue:BACKGROUND_COLOR alpha:1];
    self.backView.image=self.backImage;
    
    UIColor * color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbarbg_2"]];
    [self.btnBack setBackgroundColor:color];
    [self.btnRetart setBackgroundColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnBackAction:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)btnRestartAction:(id)sender
{
    if (self.callback) {
        self.callback();
    }
    [self dismissViewControllerAnimated:NO  completion:nil];
}



@end
