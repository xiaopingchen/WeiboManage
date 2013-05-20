//
//  WeiboRequest.m
//  WeiboManage
//
//  Created by chen xiaoping on 5/20/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import "WeiboRequest.h"
#import "Constant.h"
#import "WeiboAccounts.h"

NSString *WeiboApiErrorDomian=@"com.zhiweibo.api";
NSString *kUserAgent=@"ZhiWeibo";
static const int kGeneralErrorCode=10000;

@interface WeiboRequest()

-(NSString *)serializeURL:(NSString *)baseUrl params:(NSDictionary *)params;

@end

@implementation WeiboRequest

- (id)init
{
    self = [super init];
    if (self) {
        WeiboAccount *account=[[WeiboAccounts shared]currentAccount];
        if (account) {
            self.accessToken=account.accessToken;
        }
    }
    return self;
}

-(id)initWithDelegate:(id<WeiboRequestDelegate>)delegate{
    self=[super init];
    if (self) {
        self.delegate=delegate;
    }
    return self;
}

-(id)initWithAccessToken:(NSString *)accessToken delegate:(id<WeiboRequestDelegate>)delegate{
    self=[super init];
    if (self) {
        self.accessToken=accessToken;
        self.delegate=delegate;
    }
    
    return self;
}

-(void)processParams:(NSMutableDictionary *)params{
    if (!params) {
        params=[NSMutableDictionary new];
    }
    if (self.accessToken) {
        [params setObject:self.accessToken forKey:@"access_token"];
    }
}

-(NSString *)serializeURL:(NSString *)baseUrl params:(NSDictionary *)params
{
    NSURL *url=[NSURL ]
}

-(void)getFromPath:(NSString *)apiPath params:(NSMutableDictionary *)params{
    NSString *fullUrl=[kWeiboAPIBaseUrl stringByAppendingString:apiPath];
    return [self getFromUrl:fullUrl params:params];
}

-(void)getFromUrl:(NSString *)url params:(NSMutableDictionary *)params{
    [self processParams:params];
    
//    NSString *urlString=[self class] ser
}

@end


