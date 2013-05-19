//
//  WeiboSignInViewController.m
//  WeiboManage
//
//  Created by Mac mini on 13-5-19.
//  Copyright (c) 2013年 chen xiaoping. All rights reserved.
//

#import "WeiboSignInViewController.h"

@interface WeiboSignInViewController ()

@end

@implementation WeiboSignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cancelButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        _stopButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stop:)];
    
        _refreshButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
        
        _stopButton.style=UIBarButtonItemStylePlain;
        _refreshButton.style=UIBarButtonItemStylePlain;
    }
    return self;
}

-(void)cancel:(id)sender
{
    [hud hide:YES];
    _closed=YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)stop:(id)sender
{
    
}

-(void)refresh:(id)sender
{
    _closed=NO;
    NSURL *url=[NSURL URLWithString:self.authentication.authorizeURL];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem=_cancelButton;
    self.navigationItem.rightBarButtonItem=_refreshButton;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.title=@"loading";
    self.navigationItem.rightBarButtonItem=_stopButton;
    if (!hud) {
        hud=[[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.view addSubview:hud];
        
        hud.delegate=self;
        hud.labelText=@"Loading";
        [hud show:YES];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.rightBarButtonItem=_refreshButton;
    [hud hide:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.title=@"loading failed";
    self.navigationItem.rightBarButtonItem=_refreshButton;
    hud.labelText=@"loading failed";
    [hud hide:YES afterDelay:2];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSRange range=[request.URL.absoluteString rangeOfString:@"code="];
    if (range.location!=NSNotFound) {
        NSString *code=[request.URL.absoluteString substringFromIndex:range.location+range.length];
        
        if ([_delegate respondsToSelector:@selector(didReceiveAuthorizeCode:)]) {
            [_delegate performSelector:@selector(didReceiveAuthorizeCode:) withObject:code];
        }
        
        [self cancel:nil];
    }
    
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    _webView.delegate=self;
    [self.view addSubview:_webView];
    
    self.navigationItem.leftBarButtonItem=_cancelButton;
    self.navigationItem.rightBarButtonItem=_refreshButton;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark MBProgressHUDDelegate methods
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
}


@end
