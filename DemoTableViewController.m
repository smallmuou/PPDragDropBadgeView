//
//  DemoTableViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 5/21/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DemoTableViewController.h"
#import "PPDragDropBadgeView.h"
#import "TableViewCell.h"

@interface DemoTableViewController ()


@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier1"];
    
    self.tableData = @[
                       @{
                           @"section":@"addSubview",
                           @"identifier":@"reuseIdentifier",
                           },
                       @{
                           @"section":@"accessoryView",
                           @"identifier":@"reuseIdentifier1",
                           },
                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* info = self.tableData[indexPath.row];
    
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:info[@"identifier"] forIndexPath:indexPath];
    cell.textLabel.text = info[@"section"];
    if ([info[@"identifier"] isEqualToString:@"reuseIdentifier"]) {
        cell.badgeView.text = [NSString stringWithFormat:@"%lu", indexPath.row+1];
    } else {
        //accessoryView
        PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(10, 10, 25, 25) dragdropCompletion:^{
            NSLog(@"Drag Drop Done.");
        }];
        badge.text = [NSString stringWithFormat:@"%lu", indexPath.row+1];
        
        //Please add to container first
        UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [container addSubview:badge];
        cell.accessoryView = container;
    }
    
    return cell;
}

@end
