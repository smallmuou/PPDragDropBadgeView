//
//  ViewController.h
//  PPDragDropBadgeView
//
//  Created by StarNet on 3/30/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UISegmentedControl* locationSegmentedControl;
@property (nonatomic, retain) IBOutlet UITextField* radiusTextField;
@property (nonatomic, retain) IBOutlet UISegmentedControl* tintColorSegmentedControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl* borderColorSegmentedControl;
@property (nonatomic, retain) IBOutlet UITextField* borderWidthTextField;
@property (nonatomic, retain) IBOutlet UITextField* textTextField;

@property (nonatomic, retain) IBOutlet UIView* testView;

@end

