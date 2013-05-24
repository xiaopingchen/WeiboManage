//
//  TableDemoViewController.m
//  WeiboManage
//
//  Created by chen xiaoping on 5/23/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import "WeiboAccounts.h"
#import "TableDemoViewController.h"
#import "TimelineQuery.h"

@interface TableDemoViewController ()

@end

@implementation TableDemoViewController
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
        
        _status=[NSMutableArray new];
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
        WeiboAccount *account= [[WeiboAccounts shared]addAccountWithAuthentication:auth];
        [WeiboAccounts shared].currentAccount=account;
        //        [[WeiboAccounts shared] setCurrentAccount:account];
        
        
        NSLog(@"succeed");
    }
    [self.tableView reloadData];
}

-(void)signIn:(id)sender
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[WeiboAccounts shared]currentAccount]!=nil) {
        [self loadTimeline];
    }
    else
    {
        [_weiboSignIn signInOnViewController:self];
    }
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)loadTimeline
{
    TimelineQuery *tq=[[TimelineQuery alloc]init];
    tq.completionBlock=^( WeiboRequest *request, NSMutableArray *statuses, NSError *error)
    {
        for (Status *stu in statuses) {
            [_status addObject:stu];
        }
        
        [self.tableView reloadData];
    };
    [tq queryUserTimelineWithUid:[WeiboAccounts shared].currentAccount.userId sinceId:0 count:20];
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
    return _status.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"WeiboAccountCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Status *weibo=[_status objectAtIndex:indexPath.row];
    cell.textLabel.text=weibo.text;
    
    return  cell;
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
