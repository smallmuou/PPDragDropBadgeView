//
//  main.m
//  PPDragDropBadgeView
//
//  Created by StarNet on 3/30/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/* 异常退出捕获 */
void uncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *body = [NSString stringWithFormat:@"&body=%@\n\n原因:\n%@\n\n调用栈:\n%@", name, reason,[arr componentsJoinedByString:@"\r\n"]];
    
    NSLog(@"%@", body);
    sleep(1);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSSetUncaughtExceptionHandler (&uncaughtExceptionHandler);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
