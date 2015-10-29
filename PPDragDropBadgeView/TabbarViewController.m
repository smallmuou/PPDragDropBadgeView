//
//  TabbarViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 10/29/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "TabbarViewController.h"
#import "PPDragDropBadgeView.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
    badge.text = @"8";
    [self.tabbar addSubview:badge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
