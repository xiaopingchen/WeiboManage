//
//  TableDemoViewController.h
//  WeiboManage
//
//  Created by chen xiaoping on 5/23/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSignIn.h"

@interface TableDemoViewController : UITableViewController<WeiboSignInDelegate>
{
        WeiboSignIn *_weiboSignIn;
    NSMutableArray *_status;
}

-(void)loadTimeline;

@end
