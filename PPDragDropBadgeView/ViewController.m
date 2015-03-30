//
//  ViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 3/30/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ViewController.h"
#import "PPDragDropBadgeView.h"

@interface ViewController () {
    PPDragDropBadgeView* _badgeView;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
