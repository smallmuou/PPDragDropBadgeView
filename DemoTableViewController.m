//
//  DemoTableViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 5/21/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DemoTableViewController.h"
#import "PPDragDropBadgeView.h"

@interface DemoTableViewController ()

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = @"BadgeView";
    
    PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithSuperView:cell location:CGPointMake(cell.bounds.size.width - 50, 35) radius:10 dragdropCompletion:^{
        NSLog(@"Done");
    }];
    badge.text = [NSString stringWithFormat:@"%lu", indexPath.row];
        
    return cell;
}



@end
