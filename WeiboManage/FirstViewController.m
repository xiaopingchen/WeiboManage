//
//  FirstViewController.m
//  WeiboManage
//
//  Created by chen xiaoping on 5/17/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
        NSLog(@"succeed");
    }
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

@end
