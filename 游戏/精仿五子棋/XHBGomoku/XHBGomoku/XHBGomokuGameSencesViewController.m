//
//  XHBGomokuGameSencesViewController.m
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import "XHBGomokuGameSencesViewController.h"
#import "XHBGomokuPieceView.h"
#import "HBPlaySoundUtil.h"
#import "UIColor+setting.h"
#import "XHBGomokuOverViewController.h"

@interface XHBGomokuGameSencesViewController ()
@property(nonatomic,weak)IBOutlet UIView * boardView;
@property(nonatomic,strong)XHBGomokuGameEngine * game;
@property(nonatomic,weak)IBOutlet UIButton * btnSound;
@property(nonatomic,weak)IBOutlet UIButton * btnUndo;
@property(nonatomic,weak)IBOutlet UIButton * btnRestart;
@property(nonatomic,weak)IBOutlet UILabel * blackChessMan;
@property(nonatomic,weak)IBOutlet UILabel * whiteChessMan;
@property(nonatomic,weak)IBOutlet UIView * topView;
@property(nonatomic)BOOL soundOpen;
@property(nonatomic,strong)NSMutableArray * pieces;
@property(nonatomic)NSInteger undoCount;
@property(nonatomic,strong)XHBGomokuPieceView * lastSelectPiece;
@end

@implementation XHBGomokuGameSencesViewController

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
    [UIApplication sharedApplication].statusBarHidden=YES;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.boardView addGestureRecognizer:tap];
    self.game=[XHBGomokuGameEngine game];
    self.game.delegate=self;
    self.game.playerFirst=YES;
    self.view.backgroundColor=[UIColor colorWithIntegerValue:BACKGROUND_COLOR alpha:1];
    
    UIColor * color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbarbg_2"]];
    self.topView.backgroundColor=color;
    self.blackChessMan.textColor=color;
    self.whiteChessMan.textColor=color;
    
    NSNumber* number=[[NSUserDefaults standardUserDefaults] objectForKey:@"soundOpen"];
    if (number) {
        [self.btnSound setSelected:!number.boolValue];
    }
    _pieces=[NSMutableArray array];
    number=[[NSUserDefaults standardUserDefaults] objectForKey:@"playerFirst"];
    if (number) {
        self.game.playerFirst=number.boolValue;
    }
    if (!self.game.playerFirst) {
        self.blackChessMan.text=@"Computer";
        self.whiteChessMan.text=@"Player";
    }else{
        self.blackChessMan.text=@"Player";
        self.whiteChessMan.text=@"Computer";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.game begin];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tapAction:(UITapGestureRecognizer*)tap
{
    CGPoint point=[tap locationInView:self.boardView];
    NSInteger tapRow=0;
    NSInteger tapLine=0;
    for (NSInteger row=1; row<=15; row++) {
        if (point.y>(21*(row-1)+3)&&point.y<(21*(row-1)+23)) {
            tapRow=row;
            break;
        }
    }
    for (NSInteger line=1; line<=15; line++) {
        if (point.x>(21*(line-1)+3)&&point.x<(21*(line-1)+23)) {
            tapLine=line;
            break;
        }
    }
    [self.game playerChessDown:tapRow line:tapLine];
}


-(IBAction)btnChangePlayChess:(id)sender
{
    if (self.game.gameStatu!=XHBGameStatuComputerChessing) {
        if (self.game.playerFirst) {
            self.game.playerFirst=NO;
            self.blackChessMan.text=@"Computer";
            self.whiteChessMan.text=@"Player";
        }else{
            self.game.playerFirst=YES;
            self.blackChessMan.text=@"Player";
            self.whiteChessMan.text=@"Computer";
        }
        NSNumber * number=[NSNumber numberWithBool:self.game.playerFirst];
        [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"playerFirst"];
        [self.game reStart];
    }
}
-(IBAction)btnBackAction:(id)sender
{}
-(IBAction)btnSoundAction:(id)sender
{
    self.btnSound.selected=!self.btnSound.selected;
    self.soundOpen=!self.btnSound.selected;
    NSNumber * number=[NSNumber numberWithBool:!self.btnSound.selected];
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"soundOpen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(IBAction)btnRestartAction:(id)sender
{
    [self.game reStart];
}
-(IBAction)btnUndoAction:(id)sender
{
    if ([self.game undo]) {
        self.undoCount++;
        if (self.undoCount>=3) {
            self.btnUndo.enabled=NO;
            [self.btnUndo setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            self.btnUndo.enabled=YES;
            [self.btnUndo setTitleColor:[self.btnRestart titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
        }
        [self.btnUndo setTitle:[NSString stringWithFormat:@"UNDO(%ld)",(long)(3-self.undoCount)] forState:UIControlStateNormal];
    };
}


-(void)game:(XHBGomokuGameEngine*)game updateSences:(XHBGomokuChessPoint*)point
{
    XHBGomokuPieceView * view=[XHBGomokuPieceView piece:point];
    [self.boardView addSubview:view];
    [_pieces addObject:view];
    
    [view setSelected:YES];
    [self.lastSelectPiece setSelected:NO];
    self.lastSelectPiece=view;
}

-(void)game:(XHBGomokuGameEngine*)game finish:(BOOL)success
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lastSelectPiece setSelected:NO];
        self.lastSelectPiece=nil;
        for (XHBGomokuChessPoint * point in game.chessBoard.successPoints) {
            for (XHBGomokuPieceView * view in self.pieces) {
                if (view.point==point) {
                    [view setSelected:YES];
                }
            }
        }
        UIStoryboard * story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        XHBGomokuOverViewController * controller=[story instantiateViewControllerWithIdentifier:@"XHBGomokuOverViewController"];
        controller.success=success;
        controller.backImage=[self  screenshot:[UIApplication sharedApplication].keyWindow];
        [controller setCallback:^{
            [self.game reStart];
        }];
        [self presentViewController:controller animated:NO completion:nil];
    });
}

-(void)game:(XHBGomokuGameEngine*)game error:(XHBGameErrorType)errorType
{}

-(void)game:(XHBGomokuGameEngine*)game playSound:(XHBGameSoundType)soundType
{
    if (self.soundOpen) {
        if (soundType==XHBGameSoundTypeStep) {
            [[HBPlaySoundUtil shareForPlayingSoundEffectWith:@"down.wav"] play];
        }else if(soundType==XHBGameSoundTypeError){
            [[HBPlaySoundUtil shareForPlayingSoundEffectWith:@"lost.wav"] play];
        }else if(soundType==XHBGameSoundTypeFailed){
            [[HBPlaySoundUtil shareForPlayingSoundEffectWith:@"au_gameover.wav"] play];
        }else if(soundType==XHBGameSoundTypeVictory){
            [[HBPlaySoundUtil shareForPlayingSoundEffectWith:@"au_victory.wav"] play];
        }else if(soundType==XHBGameSoundTypeTimeOver){
            [[HBPlaySoundUtil shareForPlayingSoundEffectWith:@""] play];
        }
    }
}

-(void)game:(XHBGomokuGameEngine *)game statuChange:(XHBGameStatu)gameStatu
{}

-(void)gameRestart:(XHBGomokuGameEngine*)game
{
    self.undoCount=0;
    if (self.undoCount>=3) {
        self.btnUndo.enabled=NO;
        [self.btnUndo setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else{
        self.btnUndo.enabled=YES;
        [self.btnUndo setTitleColor:[self.btnRestart titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
    }
    [self.btnUndo setTitle:[NSString stringWithFormat:@"UNDO(%ld)",(long)(3-self.undoCount)] forState:UIControlStateNormal];
    for (XHBGomokuPieceView * view in self.pieces) {
        [view removeFromSuperview];
    }
    self.pieces=[NSMutableArray array];
}

-(void)game:(XHBGomokuGameEngine*)game undo:(XHBGomokuChessPoint*)point
{
    XHBGomokuPieceView * deleteView=nil;
    for (XHBGomokuPieceView * view in self.pieces) {
        if (view.point==point) {
            [view removeFromSuperview];
            deleteView=view;
        }
    }
    if (deleteView) {
        [self.pieces removeObject:deleteView];
    }
}

-(UIImage*)screenshot:(UIView*)view
{
    CGSize imageSize =view.bounds.size;
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }
    else
    {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[view layer] renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
