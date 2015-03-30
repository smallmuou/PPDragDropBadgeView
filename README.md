# PPDragDropBadgeView
PPDragDropBadgeView is a badge view which able to drag and drop. Just like QQ 5.0 badge view.
![image](https://github.com/smallmuou/PPDragDropBadgeView/blob/master/PPDragDropBadgeView.png)

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
= [[PPDragDropBadgeView alloc] initWithSuperView:self.testView
                                        location:CGPointMake(0,0)
                                          radius:10.0f dragdropCompletion:^{
                                                         NSLog(@"Drag drop done.");
                                           }];
badgeView.text = @"6";
</pre>

* Q: Does it can be customized?
* A: Of course, you can set "location", "radius", "tintColor", "borderWidth", "borderColor". You can see the propertys provided by me.
	<pre>
	/** The location of badge view. */
	@property (nonatomic, assign) CGPoint location;
	
	/** The radius of badge view. */
	@property (nonatomic, assign) CGFloat radius;
	
	/** The completion block when drag drop done. */
	@property (nonatomic, copy) void(^dragdropCompletion)();
	
	/** The tint color of badge view. Default is red */
	@property (nonatomic, strong) UIColor* tintColor;
	
	/** The border color of badge view. Default is clear */
	@property (nonatomic, strong) UIColor* borderColor;
	
	/** The border width of badge view. Default is 1.0f */
	@property (nonatomic, assign) CGFloat borderWidth;
	
	/** The text of badge view. */
	@property (nonatomic, strong) NSString* text;
</pre>

### History
* v1.0 (March 30, 2015)
	* First release.

### License
The code follows MIT Lisence.

### Contact
If you have any questions with use it or found some bugs, you can mail to me. I will get back to you in time. The follow is my email address:
lvyexuwenfa100@126.com