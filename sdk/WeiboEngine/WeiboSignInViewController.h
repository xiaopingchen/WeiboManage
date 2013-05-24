//
//  WeiboSignInViewController.h
//  ZhiWeiboPhone
//
//  Created by junmin liu on 12-8-26.
//  Copyright (c) 2012年 idfsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboAuthentication.h"
#import "MBProgressHUD.h"

@class MBProgressHUD;

@interface WeiboSignInViewController : UIViewController<UIWebViewDelegate, MBProgressHUDDelegate> {
    UIWebView *_webView;
    UIBarButtonItem *_cancelButton;
    UIBarButtonItem *_stopButton;
    UIBarButtonItem *_refreshButton;
    

    
    MBProgressHUD *HUD;
    
    BOOL _closed;
}

@property (nonatomic, strong) WeiboAuthentication *authentication;
@property (nonatomic) id delegate;

@end
