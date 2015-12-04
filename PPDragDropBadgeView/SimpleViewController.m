//
//  SimpleViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 10/29/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "SimpleViewController.h"
#import "PPDragDropBadgeView.h"

@interface SimpleViewController () {
    PPDragDropBadgeView* _badgeView;
    PPDragDropBadgeView* _badgeView1;
    
}

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    {
        _badgeView = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(50, 100, 25, 25) dragdropCompletion:^{
            NSLog(@"Drag Drop Done.");
        }];
        
        _badgeView.text = @"8";
        [self.view addSubview:_badgeView];
    }
    
    {
        _badgeView1 = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(50, 50, 25, 25) dragdropCompletion:^{
            NSLog(@"Drag Drop Done.");
        }];
        
        _badgeView1.text = @"8";
        [self.container addSubview:_badgeView1];
    }
}

- (IBAction)onResetButtonPressed:(id)sender {
    _badgeView.text = @"6";
    _badgeView1.text = @"9";
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
