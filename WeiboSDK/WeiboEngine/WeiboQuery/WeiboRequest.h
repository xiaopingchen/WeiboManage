//
//  WeiboRequest.h
//  WeiboManage
//
//  Created by chen xiaoping on 5/20/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@class WeiboRequest;

@protocol WeiboRequestDelegate <NSObject>

@optional
-(void)request:(WeiboRequest *)request didFailWithError:(NSError *)error;
-(void)request:(WeiboRequest *)request didLoad:(id)result;

@end


@interface WeiboRequest : NSObject<ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *_request;
}
@property(nonatomic) id<WeiboRequestDelegate> delegate;
@property(nonatomic) NSError *error;
@property(nonatomic,readonly) BOOL sessionDidExpire;
@property(nonatomic,copy) NSString *accessToken;


-(id)initWithDelegate:(id<WeiboRequestDelegate>)delegate;
-(id)initWithAccessToken:(NSString *)accessToken delegate:(id<WeiboRequestDelegate>)delegate;

-(void)cancel;
-(void)getFromUrl:(NSString *)url params:(NSMutableDictionary *)params;
-(void)postToUrl:(NSString *)url params:(NSMutableDictionary *)params;

-(void)getFromPath:(NSString *)apiPath params:(NSMutableDictionary *)params;
-(void)postToPath:(NSString *)apiPath params:(NSMutableDictionary *)params;


@end
