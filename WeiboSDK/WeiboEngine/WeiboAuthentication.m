//
//  WeiboAuthentication.m
//  WeiboManage
//
//  Created by Mac mini on 13-5-17.
//  Copyright (c) 2013年 chen xiaoping. All rights reserved.
//

#import "WeiboAuthentication.h"

@implementation WeiboAuthentication

-(id)initWithAuthorizeURL:(NSString *)authorizeURL accessTokenUrl:(NSString *)accessTokenURL appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    self=[super init];
    if (self) {
        self.authorizeURL=authorizeURL;
        self.accessTokenURL=accessTokenURL;
        self.appKey=appKey;
        self.appSecret=appSecret;
        self.redirectURI=@"http://";
    }
    
    return self;
}

-(NSString *)authorizeURL
{
    return [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&redirect_uri=%@&display=mobile",_authorizeURL,[self.appKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.redirectURI stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

@end
