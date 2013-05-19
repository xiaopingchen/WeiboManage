//
//  WeiboSignIn.h
//  WeiboManage
//
//  Created by Mac mini on 13-5-18.
//  Copyright (c) 2013年 chen xiaoping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "WeiboAuthentication.h"
#import "ASIHTTPRequest.h"

@protocol WeiboSignInDelegate <NSObject>

-(void)finishedWithAuth:(WeiboAuthentication *)auth error:(NSError *)error;

@end


@interface WeiboSignIn : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic) WeiboAuthentication *authentication;
@property (nonatomic) id<WeiboSignInDelegate> delegate;

-(void)signInOnViewController:(UIViewController *)viewController;

@end
