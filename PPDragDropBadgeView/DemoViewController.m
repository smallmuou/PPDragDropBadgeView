//
//  DemoViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 10/28/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "DemoViewController.h"
#import "PPDragDropBadgeView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(100, 100, 25, 25) dragdropCompletion:^{
        NSLog(@"badge.....");
    }];
    badge.text  = @"99";
    [self.view addSubview:badge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
