//
//  NavigationBarViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 10/29/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "PPDragDropBadgeView.h"

@interface NavigationBarViewController ()
@end

@implementation NavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    {
        PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        badge.text = @"8";
        
        UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        container.backgroundColor = [UIColor clearColor];
        [container addSubview:badge];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:container];
    }
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
