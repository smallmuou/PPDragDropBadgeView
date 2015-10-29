//
//  TableViewCell.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 10/29/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.badgeView = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 20, 25, 25) dragdropCompletion:^{
        NSLog(@"TableViewCell drag done.");
    }];
    
    self.badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:self.badgeView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
