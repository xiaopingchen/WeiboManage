//
//  WeiboAccount.h
//  WeiboManage
//
//  Created by chen xiaoping on 5/20/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboAccount : NSObject<NSCoding>

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic) NSDate *expirationDate;
@property (nonatomic,copy) NSString *screenName;
@property (nonatomic,copy) NSString *profileImageUrl;
@property (nonatomic) BOOL selected;

@end
