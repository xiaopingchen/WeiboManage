//
//  FirstViewController.h
//  WeiboManage
//
//  Created by chen xiaoping on 5/17/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSignIn.h"

@interface FirstViewController : UITableViewController<WeiboSignInDelegate>
{
    WeiboSignIn *_weiboSignIn;
}
@end
