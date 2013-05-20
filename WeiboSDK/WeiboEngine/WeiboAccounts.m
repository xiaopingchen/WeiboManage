//
//  WeiboAccounts.m
//  WeiboManage
//
//  Created by chen xiaoping on 5/20/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import "WeiboAccounts.h"


@interface WeiboAccounts ()

-(NSString *)getWeiboAccountsStoragePath;

@end

static WeiboAccounts *gInstance;

@implementation WeiboAccounts

-(id)init
{
    self=[super init];
    if(self){
        _accounts=[[NSMutableArray alloc] init];
        _accountsDic=[[NSMutableDictionary alloc] init];
    }
    return self;
}

+(WeiboAccounts *)shared{
    if(!gInstance)
    {
        gInstance=[[WeiboAccounts alloc]init];
        [gInstance loadWeiboAccounts];
    }
    
    return gInstance;
}

-(NSString *)getWeiboAccountsStoragePath{
    
}

-(void)loadWeiboAccounts{
    NSString *filePath=[self getWeiboAccountsStoragePath];
    NSArray *weiboAccounts=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!weiboAccounts) {//why
        weiboAccounts=[[NSMutableArray alloc]init];
        [NSKeyedArchiver archiveRootObject:weiboAccounts toFile:filePath];
    }
    
    _accounts=[NSMutableArray arrayWithArray:weiboAccounts];
    for (WeiboAccount *account in _accounts) {
        [_accountsDic setObject:account forKey:account.userId];
    }
}

-(void)saveWeiboAccounts{
    [NSKeyedArchiver archiveRootObject:_accounts toFile:[self getWeiboAccountsStoragePath]];
}

-(void)syncAccount:(WeiboAccount *)account{
    
}

-(void)addAccount:(WeiboAccount *)account{
    WeiboAccount *addedAccount=[_accountsDic objectForKey:account.userId];
    if (addedAccount) {
        addedAccount.accessToken=account.accessToken;
        addedAccount.expirationDate=account.expirationDate;
    }
    else{
        addedAccount=account;
        if (_accounts.count==0) {
            account.selected=YES;
        }
        [_accountsDic setObject:account forKey:account.userId];
        [_accounts insertObject:account atIndex:0];
    }
    [self saveWeiboAccounts];
    if (!account.screenName||!account.profileImageUrl) {
        [self syncAccount:account];
    }
}

-(void)removeWeiboAccount:(WeiboAccount *)account
{
    WeiboAccount *accoutnToRemoved=[_accountsDic objectForKey:account.userId];
    BOOL isCurrentAccount=account.selected;
    if (accoutnToRemoved) {
        [_accounts removeObject:accoutnToRemoved];
        [_accountsDic removeObjectForKey:accoutnToRemoved.userId];
    }
    if (isCurrentAccount) {
        if (_accounts.count>0) {
            [[_accounts objectAtIndex:0] setSelected:YES];
        }
    }
    
    [self saveWeiboAccounts];
}

-(void)setCurrentAccount:(WeiboAccount *)currentAccount{
    for (WeiboAccount *account in _accounts) {
        account.selected=[account.userId isEqualToString:currentAccount.userId];
    }
    [self saveWeiboAccounts];
}


-(WeiboAccount *)currentAccount{
    for (WeiboAccount *account in _accounts) {
        if (account.selected) {
            return account;
        }
    }
    
    return nil;
}

-(void)signOut{
    WeiboAccount *current=[self currentAccount];
    if (current) {
        [self removeWeiboAccount:current];
    }
}

-(void)addAccountWithAuthentication:(WeiboAuthentication *)auth{
    WeiboAccount *account=[[WeiboAccount alloc]init];
    account.accessToken=auth.accessToken;
    account.userId=auth.userId;
    account.expirationDate=auth.expirationDate;
    
    [self addAccount:account];
}


@end
