//
//  WeiboSignIn.m
//  WeiboManage
//
//  Created by Mac mini on 13-5-18.
//  Copyright (c) 2013年 chen xiaoping. All rights reserved.
//

#import "WeiboSignIn.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "WeiboSignInViewController.h"

NSString *WeiboOAuth2ErrorDomain=@"com.zhiweibo.OAuth2";

@interface WeiboSignIn ()

-(void)accessTokenWithAuthorizeCode:(NSString *)code;
-(void)didReceiveAuthorizeCode:(NSString *)code;

@end

@implementation WeiboSignIn

-(id)init
{
    self=[super init];
    if (self) {
        self.authentication=[[WeiboAuthentication alloc] initWithAuthorizeURL:kWeiboAuthorizeURL accessTokenUrl:kWeiboAccessTokenURL appKey:kAppKey appSecret:kAppSecret];
    }
    
    return self;
}

-(void)accessTokenWithAuthorizeCode:(NSString *)code
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.authentication.accessTokenURL]];
    [request addPostValue:self.authentication.appKey forKey:@"client_id"];
    [request addPostValue:self.authentication.appSecret forKey:@"client_secret"];
    [request addPostValue:self.authentication.redirectURI forKey:@"redirect_uri"];
    [request addPostValue:code forKey:@"code"];
    [request addPostValue:@"authorization_code" forKey:@"grant_type"];
    [request setDelegate:self];
    [request startAsynchronous];
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:request.responseData options:nil error:nil];
    if ([dataDic isKindOfClass:[NSDictionary class]]) {
        NSString *accessToken=[dataDic objectForKey:@"access_token"];
        NSString *userId=[dataDic objectForKey:@"uid"];
        int expiredIn=[[dataDic objectForKey:@"expires_in"] intValue];
        
        if (accessToken.length>0&&userId.length>0) {
            self.authentication.accessToken=accessToken;
            self.authentication.userId=userId;
            self.authentication.expirationDate=[NSDate dateWithTimeIntervalSinceNow:expiredIn];
            
            if (_delegate) {
                [_delegate finishedWithAuth:self.authentication error:nil];
            }
            
            return;
        }
    }
    
    NSDictionary *userInfo=@{[NSString stringWithFormat:@"failed to parse response data:\r\n%@",request.responseString]:NSLocalizedDescriptionKey};
    NSError *error=[NSError errorWithDomain:@"xp" code:1 userInfo:userInfo];
    if (_delegate) {
        [_delegate finishedWithAuth:self.authentication error:error];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSDictionary *userInfo=@{[NSString stringWithFormat:@"failed to parse response data:\r\n%@",request.responseString]:NSLocalizedDescriptionKey};
    NSError *error=[NSError errorWithDomain:@"xp" code:1 userInfo:userInfo];
    if (_delegate) {
        [_delegate finishedWithAuth:self.authentication error:error];
    }
}

-(void)signInOnViewController:(UIViewController *)viewController
{
    WeiboSignInViewController *signInController=[[WeiboSignInViewController alloc] initWithNibName:nil bundle:nil];
    signInController.delegate=self;
    signInController.authentication=self.authentication;
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:signInController];
    [viewController presentViewController:navController animated:YES completion:nil];
}

-(void)didReceiveAuthorizeCode:(NSString *)code
{
    if (![code isEqualToString:@"21330"]) {
        [self accessTokenWithAuthorizeCode:code];
    }
    else{
        NSDictionary *userInfo=@{@"Access denied": NSLocalizedDescriptionKey};
        NSError *error=[NSError errorWithDomain:WeiboOAuth2ErrorDomain code:@"22" userInfo:userInfo];
        if (_delegate) {
            [_delegate finishedWithAuth:self.authentication error:error];
        }
        
    }
}


@end
