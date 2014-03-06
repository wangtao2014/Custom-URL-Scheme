//
//  WTInvokingViewController.m
//  InvokingDemo
//
//  Created by wangtao on 14-3-6.
//  Copyright (c) 2014年 hello. All rights reserved.
//

#import "WTInvokingViewController.h"

@interface WTInvokingViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation WTInvokingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect rectTextView= CGRectMake(10.0f, 30.0f, 300.0f, 100.0f);
    self.textView = [[UITextView alloc] initWithFrame:rectTextView];
    [self.textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.textView.layer setBorderWidth:0.5f];
    [self.textView setText:@"username=WT&password=123456&callback=invoking"];
    [self.view addSubview:self.textView];
    
    CGRect rect = CGRectMake(10.0f, 150.0f, 300.0f, 40.0f);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = rect;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Login" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(handle:) forControlEvents:UIControlEventTouchUpInside];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0f];
    [self.view addSubview:button];
}

- (void)handle:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"invoked://com.hello/path?%@", self.textView.text]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"message" message:[NSString stringWithFormat:@"%@", url] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
