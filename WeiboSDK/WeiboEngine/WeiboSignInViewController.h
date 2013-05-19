//
//  WeiboSignInViewController.h
//  WeiboManage
//
//  Created by Mac mini on 13-5-19.
//  Copyright (c) 2013年 chen xiaoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboAuthentication.h"
#import "MBProgressHUD.h"

@interface WeiboSignInViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>
{
    UIBarButtonItem *_cancelButton;
    UIBarButtonItem *_stopButton;
    UIBarButtonItem *_refreshButton;
    
    UIWebView *_webView;
    
    BOOL _closed;
    MBProgressHUD *hud;
}

@property (nonatomic) WeiboAuthentication *authentication;
@property (nonatomic) id delegate;

@end
