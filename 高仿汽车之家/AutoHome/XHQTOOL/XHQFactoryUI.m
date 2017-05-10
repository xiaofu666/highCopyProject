//
//  XHQFactoryUI.m
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQFactoryUI.h"

@implementation XHQFactoryUI
+(UIView *)createViewWithFrame:(CGRect)frame;
{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    return view;
}
//UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}
//UIButton
+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    //设置标题
    [button setTitle:title forState:UIControlStateNormal];
    //设置标题颜色
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    //设置图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    //添加点击事件
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
//UIImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}
//UITextField
+(UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder
{
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    textField.text = text;
    textField.placeholder = placeHolder;
    return textField;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com