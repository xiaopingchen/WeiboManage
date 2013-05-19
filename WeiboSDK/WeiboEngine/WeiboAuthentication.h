//
//  WeiboAuthentication.h
//  WeiboManage
//
//  Created by Mac mini on 13-5-17.
//  Copyright (c) 2013年 chen xiaoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboAuthentication : NSObject

@property (nonatomic,copy) NSString *appKey;
@property (nonatomic,copy) NSString *appSecret;
@property (nonatomic,copy) NSString *redirectURI;

@property (nonatomic,copy) NSString *authorizeURL;
@property (nonatomic,copy) NSString *accessTokenURL;

@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic) NSDate *expirationDate;

-(NSString *)authorizeURL;

-(id)initWithAuthorizeURL:(NSString *)authorizeURL accessTokenUrl:(NSString *)accessTokenURL appKey:(NSString *)appKey appSecret:(NSString *)appSecret;

@end
