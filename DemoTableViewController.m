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
    
    self.title = @"PPDragDropBadgeView";
    
    PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.bounds.size.width-50, 10, 25, 25)];
    badge.text = @"8";
    badge.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    [self.navigationController.navigationBar addSubview:badge];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
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
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.badgeView.text = [NSString stringWithFormat:@"%lu", indexPath.row+1];
    cell.xibBadgeView.text = [NSString stringWithFormat:@"%lu", indexPath.row+1];
    return cell;
}

@end
