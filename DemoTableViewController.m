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
    
    self.title = @"PPDragDropBadgeView";
    
    PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    badge.text = @"8";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:badge];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = @"BadgeView";
    
    
    PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) dragdropCompletion:^{
        NSLog(@"Drag Done");
    }];
    
    badge.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    cell.accessoryView = badge;
    
    return cell;
}



@end
