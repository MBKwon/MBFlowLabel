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
    [self.view addSubview:flowLabel];
    [flowLabel setTextMargin:10.0];
    [flowLabel setAttributedText:[[NSAttributedString alloc] initWithString:@"abcdefghijklmnopqrstuvwxyz"
                                                                 attributes:@{NSForegroundColorAttributeName : UIColor.greenColor,
                                                                              NSFontAttributeName : [UIFont systemFontOfSize:17.0],
                                                                              NSKernAttributeName : @(-0.5)}]];
    
    flowLabel = [[MBFlowLabelView alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    [self.view addSubview:flowLabel];
    [flowLabel setText:@"abcde"];
}

@end
