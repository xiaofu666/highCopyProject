//
//  KeyboardView.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "KeyboardView.h"
@interface KeyboardView()<UITextFieldDelegate>

@end
@implementation KeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:246/255.0 alpha:1];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        
        [self addEnterNofi];
        [self addKeyNofi];
        
        [self addSubview:self.soundBtn];
        [self addSubview:self.messageField];
        [self addSubview:self.faceBtn];
        [self addSubview:self.moreBtn];
    }
    return self;
}

- (void)addEnterNofi
{
    //进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(enterForeground)
                                                 name:@"EnterForeground" object:nil];
    //进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(enterBackground)
                                                 name:@"EnterBackground" object:nil];
}

- (void)addKeyNofi
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)enterForeground
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addKeyNofi];
    });
}

- (void)enterBackground
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    NSInteger anType = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
 
    if (self.showBlock)
    {
        self.showBlock(anType,duration,kbSize);
    }

}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    NSInteger anType = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    
        if (self.hideBlock)
        {
            self.hideBlock(anType,duration,kbSize);
        }
}


- (UIButton *)soundBtn
{
    if (!_soundBtn)
    {
        _soundBtn = ({
            UIButton * soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            soundBtn.frame = CGRectMake(5,(self.frame.size.height - 28)/2.0, 28, 28);
            
            [soundBtn setBackgroundImage:[UIImage imageNamed:@"chat_setmode_voice_btn_normal"] forState:UIControlStateNormal];
            
            soundBtn;
        });
    }
    return _soundBtn;
}

- (UITextField *)messageField
{
    if (!_messageField)
    {
        _messageField = ({
        
            UITextField * messageField = [[UITextField alloc]initWithFrame:CGRectMake(5 + 30 + 10, (self.frame.size.height - 35)/2.0,self.frame.size.width - 15 - 30 - 20 - 60 - 5, 35)];
            
            messageField.layer.cornerRadius = 4;
            
            messageField.clipsToBounds = YES;
            
            messageField.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
            
            messageField.backgroundColor = [UIColor whiteColor];
            
            messageField.layer.borderWidth = 1;
            
            messageField.delegate = self;
            
            messageField.returnKeyType = UIReturnKeySend;
            
            messageField.enablesReturnKeyAutomatically = YES;
            
            messageField;
        });
    }
    return _messageField;
}

- (UIButton *)faceBtn
{
    if (!_faceBtn)
    {
        _faceBtn = ({
            
            UIButton * faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                
            faceBtn.frame = CGRectMake(self.frame.size.width - 15 - 60, (self.frame.size.height - 30)/2.0, 30, 30);
            
            [faceBtn setBackgroundImage:[UIImage imageNamed:@"Album_ToolViewEmotion"] forState:UIControlStateNormal];
            [faceBtn setBackgroundImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"] forState:UIControlStateHighlighted];
            faceBtn;
        });
    }
    return _faceBtn;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn)
    {
        _moreBtn = ({
            
            UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            moreBtn.frame = CGRectMake(self.frame.size.width - 30 - 5, (self.frame.size.height - 28)/2.0, 28, 28);
            
            [moreBtn setBackgroundImage:[UIImage imageNamed:@"chat_setmode_add_btn_normal"] forState:UIControlStateNormal];
            
            moreBtn;
        });
    }
    return _moreBtn;
}

- (void)setShowBlock:(void (^)(NSInteger, CGFloat, CGSize))showBlock andHideBlock:(void (^)(NSInteger, CGFloat, CGSize))hideBlock
{
    _showBlock = showBlock;
    
    _hideBlock = hideBlock;
}

#pragma mark -- textField --

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.sentBlock)
    {
        self.sentBlock(textField.text,SentMessageTypeText);
    }
    _messageField.text = nil;
    return YES;
}
@end
