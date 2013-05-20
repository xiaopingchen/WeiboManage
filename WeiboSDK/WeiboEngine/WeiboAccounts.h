//
//  WeiboAccounts.h
//  WeiboManage
//
//  Created by chen xiaoping on 5/20/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboAccount.h"
#import "WeiboAuthentication.h"

@interface WeiboAccounts : NSObject
{
    NSMutableDictionary *_accountsDic;
}

@property(nonatomic,readonly) NSMutableArray *accounts;
@property(nonatomic) WeiboAccount *currentAccount;

-(void)loadWeiboAccounts;
-(void)saveWeiboAccounts;
-(void)removeWeiboAccount:(WeiboAccount*)account;
-(void)syncAccount:(WeiboAccount *)account;

-(void)addAccount:(WeiboAccount *)account;
-(void)addAccountWithAuthentication:(WeiboAuthentication *)auth;

-(void)signOut;

+(WeiboAccounts *)shared;

@end
