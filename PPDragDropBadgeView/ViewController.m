//
//  ViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 3/30/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ViewController.h"
#import "PPDragDropBadgeView.h"
#import "DemoTableViewController.h"

@interface ViewController () {
    PPDragDropBadgeView* _badgeView;
    UITabBarController* _tabBarController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _badgeView \
    = [[PPDragDropBadgeView alloc] initWithSuperView:self.testView
                                            location:CGPointMake(0,0)
                                              radius:10.0f dragdropCompletion:^{
                                                             NSLog(@"Drag drop done.");
                                               }];
    _badgeView.text = @"6";
    
    [self onApplyButtonPressed:nil];
}


- (IBAction)onApplyButtonPressed:(id)sender {
    CGPoint location;
    switch (self.locationSegmentedControl.selectedSegmentIndex) {
        case 0:
            location = CGPointMake(0, 0);
            break;
        case 1:
            location = CGPointMake(self.testView.bounds.size.width/2, self.testView.bounds.size.height/2);
            break;
        case 2:
            location = CGPointMake(self.testView.bounds.size.width, 0);
            break;
        default:
            break;
    }

    _badgeView.location = location;

    _badgeView.radius = [self.radiusTextField.text floatValue];
    
    UIColor* tintColor;
    switch (self.tintColorSegmentedControl.selectedSegmentIndex) {
        case 0:
            tintColor = [UIColor redColor];
            break;
        case 1:
            tintColor = [UIColor greenColor];
            break;
        case 2:
            tintColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    _badgeView.tintColor = tintColor;
    
    UIColor* borderColor;
    switch (self.borderColorSegmentedControl.selectedSegmentIndex) {
        case 0:
            borderColor = [UIColor redColor];
            break;
        case 1:
            borderColor = [UIColor greenColor];
            break;
        case 2:
            borderColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    _badgeView.borderColor = borderColor;
    _badgeView.borderWidth = [self.borderWidthTextField.text floatValue];
    _badgeView.text = self.textTextField.text;
}

- (IBAction)onDemoButtonPressed:(id)sender {
    DemoTableViewController* dvc = [[DemoTableViewController alloc] initWithNibName:@"DemoTableViewController" bundle:nil];
    
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = @[dvc];
    UITabBarItem *item = [_tabBarController.tabBar.items firstObject];
    item.title = @"DEMO";
    

    
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:_tabBarController];
    _tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneButtonPressed:)];
    
    
    UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    v1.backgroundColor = [UIColor clearColor];
    PPDragDropBadgeView* bv = [[PPDragDropBadgeView alloc] initWithSuperView:v1
                                                                    location:CGPointMake(15,15)
                                                                      radius:10.0f dragdropCompletion:^{
                                                                          NSLog(@"Drag drop done.");
                                                                      }];
    bv.text = @"8";
    
    _tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:v1];
    
    [self presentViewController:nvc animated:YES completion:^{
    }];
}

- (void)onDoneButtonPressed:(id)sender {
    [_tabBarController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
