//
//  AboutViewController.h
//  YueduFM
//
//  Created by StarNet on 10/12/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView* webView;

@end
