//
//  MenuViewController.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 10/29/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "MenuViewController.h"
#import "SimpleViewController.h"
#import "NavigationBarViewController.h"
#import "TabbarViewController.h"
#import "DemoTableViewController.h"

@interface MenuViewController ()


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PPDragDropBadgeView";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    
    __weak typeof(self) weakSelf = self;
    self.tableData = @[
    @{
        @"title":@"Simple",
        @"action":^{
            SimpleViewController* vc = [[SimpleViewController alloc] initWithNibName:@"SimpleViewController" bundle:nil];
            vc.title = @"Simple";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    },
    @{
        @"title":@"NavigationBar",
        @"action":^{
            NavigationBarViewController* vc = [[NavigationBarViewController alloc] initWithNibName:@"NavigationBarViewController" bundle:nil];
            vc.title = @"NavigationBar";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        },
    @{
        @"title":@"Tabbar",
        @"action":^{
            TabbarViewController* vc = [[TabbarViewController alloc] initWithNibName:@"TabbarViewController" bundle:nil];
            vc.title = @"Tabbar";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        },
    @{
        @"title":@"TableView",
        @"action":^{
            DemoTableViewController* vc = [[DemoTableViewController alloc] initWithNibName:@"DemoTableViewController" bundle:nil];
            vc.title = @"TableView";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        },
    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    
    NSDictionary* info = self.tableData[indexPath.row];
    cell.textLabel.text = info[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* info = self.tableData[indexPath.row];
    ((void(^)())info[@"action"])();
}

@end
