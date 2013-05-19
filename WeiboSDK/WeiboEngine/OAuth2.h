//
//  OAuth2.h
//  WeiboManage
//
//  Created by chen xiaoping on 5/17/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth2 : NSObject

@property (nonatomic,copy) NSString *appKey;
@property (nonatomic,copy) NSString *appSecret;
@property (nonatomic,copy) NSString *accessToken;

@end
