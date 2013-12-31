//
//  DemoViewController.m
//  MBFlowLabel
//
//  Created by MB KWON on 2013. 12. 24..
//  Copyright (c) 2013년 MB KWON. All rights reserved.
//

#import "DemoViewController.h"
#import "MBFlowLabelView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MBFlowLabelView *flowLabel = [[MBFlowLabelView alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [flowLabel setText:@"abcdefghijklmnopqrstuvwxyz"];
    [self.view addSubview:flowLabel];
    [flowLabel setText:@"Moonbeom Kyle KWON"];
    
    flowLabel = [[MBFlowLabelView alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    [flowLabel setText:@"abcde"];
    [self.view addSubview:flowLabel];
}

@end
