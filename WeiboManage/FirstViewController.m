//
//  FirstViewController.m
//  WeiboManage
//
//  Created by chen xiaoping on 5/17/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import "WeiboAccounts.h"
#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


-(id)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        _weiboSignIn=[[WeiboSignIn alloc] init];
        _weiboSignIn.delegate=self;
        
        UIBarButtonItem *signButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(signIn:)];
        self.navigationItem.rightBarButtonItem=signButton;
    }
    return self;
}

-(void)finishedWithAuth:(WeiboAuthentication *)auth error:(NSError *)error
{
    if (error) {
        NSLog(@"failed to auth:%@",error);
    }
    else
    {
        [[WeiboAccounts shared]addAccountWithAuthentication:auth];
        NSLog(@"succeed");
    }
    [self.tableView reloadData];
}

-(void)signIn:(id)sender
{
        [_weiboSignIn signInOnViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[WeiboAccounts shared] accounts].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"WeiboAccountCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    WeiboAccount *account=[[[WeiboAccounts shared] accounts]objectAtIndex:indexPath.row];
    NSString *name=account.screenName;
    if (!name) {
        name=account.userId;
    
    }
    cell.textLabel.text=name;
    
    return  cell;
}





@end
