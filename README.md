# PPDragDropBadgeView
PPDragDropBadgeView is a badge view which able to drag and drop. Just like QQ 5.0 badge view.
![image](https://github.com/smallmuou/PPDragDropBadgeView/blob/master/PPDragDropBadgeView.gif)

* Support iOS 5.0+ ARC

### Configure
* Checkout PPDragDropBadgeView from github.
* Copy PPDragDropBadgeView folder to your project.
* Go to 'TARGET' -> 'Build Phases' -> 'Complile Sources', add compliler flags '-fno-objc-arc' for 'PRTween.m' and 'PRTweenTimingFunctions.m'
* Done.

You can also refer to the example project provided by me.

### Usage
* Q: How to use PPDragDropBadgeView? 
* A: Very simple, you only follow the down code.

	<pre>
PPDragDropBadgeView* badgeView \
= [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) dragdropCompletion:^{
                                                         NSLog(@"Drag drop done.");
                                           }];
badgeView.text = @"6";
</pre>

* Q: Does it can be customized?
* A: Of course, You can see the propertys provided by me.
	<pre>
	/** The completion block when drag drop done. */
	@property (nonatomic, copy) void(^dragdropCompletion)();
	
	/** The tint color of badge view. Default is red */
	@property (nonatomic, strong) UIColor* tintColor;
	
	/** The text of badge view. */
	@property (nonatomic, strong) NSString* text;
</pre>

### Note
you must use addSubview instead of directly use it. like 
<pre>
PPDragDropBadgeView* badge = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
badge.text = @"8";

//you must add to container first instead of [[UIBarButtonItem alloc] initWithCustomView:badge]
UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
container.backgroundColor = [UIColor clearColor];
[container addSubview:badge];

self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:container];</pre>

### History
* v2.1 (October 29, 2015)
	* Fix bug, it can on the top view some case.
	* Fix bug, it will crash when drag sometimes.
* v2.0 (July 2, 2015)
	* Fix bug, it can scroll tableview when badage in cell.
* v1.2 (June 18, 2015)
	* Fix bug, it does't drag when in innner viewcontroller.
* v1.1 (May 8, 2015)
	* Fix Bug, it will crash when drag sometimes.
* v1.0 (March 30, 2015)
	* First release.

### License
The code follows MIT Lisence.

### Contact
If you have any questions with use it or found some bugs, you can mail to me. I will get back to you in time. The follow is my email address:
lvyexuwenfa100@126.com