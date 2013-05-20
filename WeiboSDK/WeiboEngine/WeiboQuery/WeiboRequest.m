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
-(void)handleResponseData:(NSData *)data;
-(void)failWithError:(NSError *)error;
-(id)parseJsonResponse:(NSData *)data error:(NSError **)error;

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
    NSURL *url=[NSURL URLWithString:baseUrl];
    NSString *queryPrefix=url.query?@"&":@"?";
    NSMutableArray *pairs=[NSMutableArray new];
    for (NSString *key in [params keyEnumerator]) {
        if ([[params objectForKey:key] isKindOfClass:[UIImage class]]||[[params objectForKey:key] isKindOfClass:[NSData class]] ) {
            continue;
        }
        
        NSString *escapted_value=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[params objectForKey:key], NULL, (CFStringRef)@"!*'();:&=+$,/?%#[]", kCFStringEncodingUTF8));
        [pairs addObject:[NSString stringWithFormat:@"%@=%@",key,escapted_value]];
    }
    
    NSString *query=[pairs componentsJoinedByString:@"&"];
    return [NSString stringWithFormat:@"%@%@%@",baseUrl,queryPrefix,query];
}

-(void)getFromPath:(NSString *)apiPath params:(NSMutableDictionary *)params{
    NSString *fullUrl=[kWeiboAPIBaseUrl stringByAppendingString:apiPath];
    return [self getFromUrl:fullUrl params:params];
}

-(void)getFromUrl:(NSString *)url params:(NSMutableDictionary *)params{
    [self processParams:params];
    
    NSString *urlString=[self serializeURL:url params:params];
    [_request clearDelegatesAndCancel];
    _request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_request setDelegate:self];
    [_request setValidatesSecureCertificate:NO];
    [_request addRequestHeader:@"User-Agent" value:kUserAgent];
    [_request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    [self performSelectorInBackground:@selector(handleResponseData:) withObject:request.responseData];
    _request=nil;
}

-(id)formError:(NSInteger)code userInfo:(NSDictionary *)errorData{
    return [NSError errorWithDomain:WeiboApiErrorDomian code:code userInfo:errorData];
}

-(id)parseJsonResponse:(NSData *)data error:(NSError *__autoreleasing *)error{
    NSError *parseError=nil;
    id result=[NSJSONSerialization JSONObjectWithData:data options:nil error:&parseError];
    if (parseError) {
        if (error!=nil) {
            *error=[self formError:kGeneralErrorCode userInfo:parseError.userInfo];
        }
    }
    
    if ([result isKindOfClass:[NSDictionary class]]) {
        if ([result objectForKey:@"error_code"]!=nil&&[[result objectForKey:@"error_code"] intValue]!=200) {
            if (error!=nil) {
                *error=[self formError:[[result objectForKey:@"error_code"] intValue] userInfo:result];
            }
        }
    }
    return result;
}

-(void)handleResponseData:(NSData *)data
{
    NSError *error=nil;
    id result=[self parseJsonResponse:data error:&error];
    self.error=error;
    if ([_delegate respondsToSelector:@selector(request:didLoad:)]
        ||[_delegate respondsToSelector:@selector(request:didFailWithError:)]){
        if (error) {
            [self performSelectorOnMainThread:@selector(failWithError:) withObject:error waitUntilDone:YES];
        }
        else{
            [self performSelectorOnMainThread:@selector(loadSuccess:) withObject:result waitUntilDone:YES];
        }
    }
        
}

-(void)loadSuccess:(id)result{
    if ([_delegate respondsToSelector:@selector(request:didLoad:)]) {
        [_delegate request:self didLoad:result];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error=[request error];
    NSLog(@"_request failed");
    [self failWithError:error];
    _request=nil;
}

-(void)cancel
{
    if (_request) {
        [_request clearDelegatesAndCancel];
        _request=nil;
    }
}


-(void)failWithError:(NSError *)error{
    
}

@end


